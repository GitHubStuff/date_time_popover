import 'dart:async';

import '../common.dart';
import 'package:flutter/material.dart';

typedef Widget DateTimeWidget(BuildContext context, DateTime dateTime);

class DateTimeInputWidget extends StatefulWidget {
  final double pickerWidth;
  final DateTimeWidget dateTimeWidget;
  final DateTime initialDateTime;
  final ModeColor pickerBodyColors;
  final ModeColor dateWheelColors;
  final ModeColor timeWheelColors;
  final ModeColor setButtonColors;
  final ModeColor pickerHiliteColors;

  DateTimeInputWidget({
    Key key,
    @required this.pickerWidth,
    @required this.dateTimeWidget,
    this.initialDateTime,
    this.pickerBodyColors,
    this.dateWheelColors,
    this.timeWheelColors,
    this.setButtonColors,
    this.pickerHiliteColors,
  })  : assert(pickerWidth >= MINIMAL_PICKER_WIDTH),
        super(key: key);

  @override
  _DateTimeInputWidgetState createState() => _DateTimeInputWidgetState();
}

class _DateTimeInputWidgetState extends State<DateTimeInputWidget> {
  OverlayEntry _overlayEntry;
  DateTimeStream _dateTimeStream = DateTimeStream();
  PickerSize _pickerSize;
  double _width;
  double _height;
  DateTime _startingDateTime;

  @override
  void initState() {
    super.initState();
    _startingDateTime = widget.initialDateTime ?? DateTime.now();
    _pickerSize = PickerSize(width: widget.pickerWidth);
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

// Wrap the passed widget in gesture detector, the 'onTap' will bring up the popover widget
// that is wrapped in an Overlay widget
    return GestureDetector(
      child: StreamBuilder<DateTime>(
        stream: _dateTimeStream.stream,
        builder: (context, snapshot) {
          // Inital result will be null
          return widget.dateTimeWidget(context, snapshot.data);
        },
      ),
      onTap: () {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

// The overlay will figure the best place to align the widget (top or bottom),
// and with an offset
  OverlayEntry _createOverlayEntry() {
    double offsetPercentage = 0.0;
    ArrowSide arrowSide = ArrowSide.top;
    Offset renderOffset(Offset initialOffset) {
      if (initialOffset.dx + _pickerSize.pickerWidth > _width) {
        double overlap = (initialOffset.dx + _pickerSize.pickerWidth) - _width;
        offsetPercentage = overlap / _pickerSize.pickerWidth;
        return renderOffset(Offset(initialOffset.dx - overlap, initialOffset.dy));
      }
      if (initialOffset.dy + _pickerSize.totalBoundedHeight > _height) {
        arrowSide = ArrowSide.bottom;
        double newY = initialOffset.dy - _pickerSize.totalBoundedHeight - (_pickerSize.triangleHeight * 1.5);
        return renderOffset(Offset(initialOffset.dx, newY));
      }
      return initialOffset;
    }

    RenderBox renderBox = context.findRenderObject();
    var offset = renderOffset(renderBox.localToGlobal(Offset.zero));
    return OverlayEntry(
        builder: (context) => Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  width: _width,
                  child: GestureDetector(
                    onTap: () {
                      this._overlayEntry.remove();
                    },
                    child: Opacity(
                      opacity: 0.2,
                      child: Container(
                        height: _height,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: offset.dx,
                  top: offset.dy + _pickerSize.fontSize,
                  child: _stack(offsetPercentage, arrowSide),
                ),
              ],
            ));
  }

  Widget _stack(double offsetPercentage, ArrowSide arrowSide) {
    return ColorInheritedWidget(
      dateWheelColors: widget.dateWheelColors,
      pickerBodyColors: widget.pickerBodyColors,
      pickerHiliteColors: widget.pickerHiliteColors,
      setButtonColors: widget.setButtonColors,
      timeWheelColors: widget.timeWheelColors,
      child: Stack(children: <Widget>[
        BoundingContainerWithArrows(
          offsetPercentage: offsetPercentage,
          pickerSize: _pickerSize,
          arrowSide: arrowSide,
        ),
        Padding(
          padding: EdgeInsets.all(_pickerSize.triangleHeight),
          child: _popover(),
        ),
      ]),
    );
  }

  Widget _popover() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DateTimeBloc>(
          create: (BuildContext context) => DateTimeBloc(
            _startingDateTime,
          ),
        ),
        BlocProvider<PickerBloc>(create: (BuildContext context) => PickerBloc())
      ],
      child: _popoverChild(),
    );
  }

  Widget _popoverChild() {
    return Material(
      type: MaterialType.transparency,
      child: BlocBuilder<DateTimeBloc, DateTimeState>(
        builder: (context, state) {
          if (state is DateTimeSetState) {
            this._overlayEntry.remove();
            _dateTimeStream.sink.add(state.dateTime);
          }
          return PopoverContainerWidget(
            pickerSize: _pickerSize,
            initalDateTime: _startingDateTime,
          );
        },
      ),
    );
  }
}

/// Defines a class for a StreamController, that will have take care of
/// implementation details like access to the stream, and sink.
/// The 'void dispose()' abstract will "remind" implementations to
/// to call 'close()' to close the stream in the Widget class's 'void dispose()'
///
abstract class BroadcastStream<T> {
  final StreamController<T> _streamController = StreamController<T>.broadcast();
  Stream<T> get stream => _streamController.stream;
  Sink<T> get sink => _streamController.sink;

  void dispose();

  void close() => _streamController.close();
}

class DateTimeStream extends BroadcastStream<DateTime> {
  @override
  void dispose() {
    super.close();
  }
}
