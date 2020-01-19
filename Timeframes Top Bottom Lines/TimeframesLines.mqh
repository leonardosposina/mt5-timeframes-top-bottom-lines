//+------------------------------------------------------------------+
//|                                                TimeframesLines.mqh |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, Leonardo Sposina."
#property link      "https://www.mql5.com/en/users/leonardo_splinter/seller"
#property version   "1.1"

class TimeframesLines {

private:

    MqlRates priceBuffer[1];
    ENUM_TIMEFRAMES timeframe;
    string topLabel, bottomLabel;
    color lineColor;
    ENUM_LINE_STYLE lineStyle;
  
    void createLabels(void);
    void createLine(string objLabel);
  
  public:
  
    TimeframesLines(ENUM_TIMEFRAMES _timeframe, color linesColor, ENUM_LINE_STYLE _lineStyle);
    ~TimeframesLines(void);
  
    void update(void);

};

TimeframesLines::TimeframesLines(ENUM_TIMEFRAMES _timeframe, color linesColor, ENUM_LINE_STYLE linesStyle) {
  this.timeframe = _timeframe;
  this.lineColor = linesColor;
  this.lineStyle = linesStyle;

  this.createLabels();
  this.createLine(this.topLabel);
  this.createLine(this.bottomLabel);
};

TimeframesLines::~TimeframesLines() {
  ObjectDelete(0, this.topLabel);
  ObjectDelete(0, this.bottomLabel);
}

void TimeframesLines::createLabels(void) {
  string strTimeframe = EnumToString(this.timeframe);
  string strTimeframeName = StringSubstr(strTimeframe, 7);
  this.topLabel = StringFormat("%s Top", strTimeframeName);
  this.bottomLabel = StringFormat("%s Bottom", strTimeframeName);
};

void TimeframesLines::createLine(string objLabel) {
  ObjectCreate(0, objLabel, OBJ_HLINE, 0, 0, 0);
  ObjectSetInteger(0, objLabel, OBJPROP_COLOR, this.lineColor);
  ObjectSetInteger(0, objLabel, OBJPROP_STYLE, this.lineStyle);
  ObjectSetString(0, objLabel, OBJPROP_TEXT, objLabel);
  ObjectSetInteger(0, objLabel, OBJPROP_WIDTH, 1);
  ObjectSetInteger(0, objLabel, OBJPROP_SELECTABLE, false);
};

void TimeframesLines::update() {
  CopyRates(_Symbol, this.timeframe, 0, 1, this.priceBuffer);
  ObjectMove(0, this.topLabel, 0, 0, this.priceBuffer[0].high);
  ObjectMove(0, this.bottomLabel, 0, 0, this.priceBuffer[0].low);
};
