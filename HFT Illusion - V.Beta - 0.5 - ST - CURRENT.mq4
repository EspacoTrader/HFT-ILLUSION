#property copyright "HFT ILLUSION"
#property link      "https://www.facebook.com/FenixCapital.Ltda"
#property version   "0.40"
#property strict
#include <stdlib.mqh>
#include <WinUser32.mqh>
#include <ChartObjects\ChartObjectsTxtControls.mqh>

#define BullColor Green //DodgerBlue
#define BearColor Red  //FireBrick

enum dbu {Constant=0,OneMinute=1,FiveMinutes=5};
//==============================================================================================
//+------------------------------------------------------------------+
   string            t_trade                      = "EXPERT MANAGEMENT"; //===============
   bool              UseDefaultPairs              = true;       // Use the default 28 pairs
   string            OwnPairs                     = "";         // Use seus pares personalizados
   dbu               DashUpdate                   = 0;          // Intervalo de atualização 0,1,5 
/*sinput*/ int           Magic_Number                 = 1981;       //
   bool              autotrade                    = true;       // Trade automático 
//==============================================================================================
   string            t_trigger                    = "TRIGGER MANAGEMENT"; //PRICE ACTION
   bool              trigger_use_Pips             = true;       //======================== 
   double            trade_MIN_pips               = 1;    //1      // Minio de pips para abrir posição //AUMENTAR PARA 5.0
   bool              trigger_use_bidratio         = true;      // Use BidRatio filtro
   double            trigger_buy_bidratio         = 60;//BD-00  // % Nivel para abrir compra
   double            trigger_sell_bidratio        = 40;//BD-00  // % Nivel para abrir venda
   bool              trigger_use_bidratio1        = true;       // Use BidRatio filtro
   double            trigger_buy_bidratio1        = 60;//BD-01  // % Nivel para abrir compra
   double            trigger_sell_bidratio1       = 40;//BD-01  // % Nivel para abrir venda
   bool              trigger_use_relstrength      = true;      // Use Relative Strength filtering (Base)
   double            trigger_buy_relstrength      = 4.0;//RSTR-00//1.0/5//Strength para abrir compra //AUMENTAR PARA 5.0
   double            trigger_sell_relstrength     = 4.0;//RSTR-00//1.0/3//Strength para abrir venda //AUMENTAR PARA 5.0
   bool              trigger_use_relstrength1     = true;       // Use Relative Strength filtering (Base)//DESLIGAR SE NAO ATIVAR
   double            trigger_buy_relstrength1     = 4.0;//RSTR-01// Strength para abrir compra
   double            trigger_sell_relstrength1    = 4.0;//RSTR-01// Strength para abrir venda
   bool              trigger_use_buysellratio     = true;       // Use Buy/Sell Ratio filtro
   double            trigger_buy_buysellratio     = 2.0;  //0.8        // Nivel para abrir //AUMENTAR PARA 2.0
   double            trigger_sell_buysellratio    = -2.0; //0.8       // Nivel para abrir venda //AUMENTAR PARA 2.0
   bool              trigger_use_gap              = true;       // Use Gap filtro
   double            trigger_gap_buy              = 2.00; //1.0       // Nivel de Gap level para abrir compra //AUMENTAR PARA 2.0
   double            trigger_gap_sell             = -2.00;//1.0      // Nivel de Gap level para abrir venda //AUMENTAR PARA 2.0
   ENUM_TIMEFRAMES   trigger_TF_Strength          = PERIOD_CURRENT;          // TimeFrame for Strength Calculations
   bool              trigger_use_Strength         = true;               // Use Strength filtering
   double            trade_MIN_Strength           = 60;                 // Minimum % Strength to open position
//==============================================================================================
//sinput   string            t_trigger1                   = "TRIGGER MANAGEMENT"; //MAPA DE CALOR
   bool              trigger_UseHeatMap1          = false;       //======================== 
   ENUM_TIMEFRAMES   trigger_TF_HM1               = 15;         // TimeFrame Heat Map 1 
   double            trade_MIN_HeatMap1           = 0.01;       // Minimo % HeatMap1 para abrir posição
   bool              trigger_UseHeatMap2          = false;       //======================== 
   ENUM_TIMEFRAMES   trigger_TF_HM2               = 30;         // TimeFrame Heat Map 2
   double            trade_MIN_HeatMap2           = 0.02;       // Minimo % HeatMap2 para abrir posição
   bool              trigger_UseHeatMap3          = false;       //======================== 
   ENUM_TIMEFRAMES   trigger_TF_HM3               = 60;        // TimeFrame Heat Map 3
   double            trade_MIN_HeatMap3           = 0.03;       // Minimo % HeatMap3 para abrir posição
   bool              trigger_UseHeatMap4          = false;      //========================
   ENUM_TIMEFRAMES   trigger_TF_HM4               = 240;       // TimeFrame Heat Map 4
   double            trade_MIN_HeatMap4           = 0.04;       // Minimo % HeatMap4 para abrir posição
   bool              trigger_UseHeatMap5          = false;      //========================
   ENUM_TIMEFRAMES   trigger_TF_HM5               = 1440;      // TimeFrame Heat Map 5
   double            trade_MIN_HeatMap5           = 0.05;       // Minimo % HeatMap5 para abrir posição
//==============================================================================================
//sinput   string            t_trigger2                   = "TRIGGER MANAGEMENT"; //MÉDIAS MOVEIS
   bool              trigger_Moving_Average1      = true;       //======================== 
   int               trade_Period_Moving_Average1 = 30;         // Periodo Média Movel 30
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT; // Moving Average Timeframe
   bool              trigger_Moving_Average2      = true;       //========================
   int               trade_Period_Moving_Average2 = 30;         // Período de Média Móvel 30
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe
   bool              trigger_Moving_Average3      = true;       //======================== 
   int               trade_Period_Moving_Average3 = 30;         // Periodo Média Movel 30
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe
   bool              trigger_Moving_Average4      = true;       //======================== 
   int               trade_Period_Moving_Average4 = 45;         // Período de Média Móvel 45
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe
   bool              trigger_Moving_Average5      = true;       //======================== 
   int               trade_Period_Moving_Average5 = 45;         // Período de Média Móvel 45
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe
   bool              trigger_Moving_Average6      = true;       //======================== 
   int               trade_Period_Moving_Average6 = 45;         // Periodo Média Movel 45
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe
   bool              trigger_Moving_Average7      = true;       //======================== 
   int               trade_Period_Moving_Average7 = 60;         // Período de Média Móvel 60
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe 
   bool              trigger_Moving_Average8      = true;       //======================== 
   int               trade_Period_Moving_Average8 = 60;         // Periodo Média Movel 60
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe 
   bool              trigger_Moving_Average9      = true;       //======================== 
   int               trade_Period_Moving_Average9 = 60;         // Período de Média Móvel 60
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe
   bool              trigger_Moving_Average10     = true;       //======================== 
   int               trade_Period_Moving_Average10= 75;         // Período de Média Móvel 75
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe 
   bool              trigger_Moving_Average11     = true;       //======================== 
   int               trade_Period_Moving_Average11= 75;         // Periodo Média Movel 75
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe 
   bool              trigger_Moving_Average12     = true;       //======================== 
   int               trade_Period_Moving_Average12= 75;         // Período de Média Móvel 75
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe 
   bool              trigger_Moving_Average13     = true;       //======================== 
   int               trade_Period_Moving_Average13= 90;         // Periodo Média Movel 90
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;//Moving Average Timeframe 
   bool              trigger_Moving_Average14     = true;       //======================== 
   int               trade_Period_Moving_Average14= 90;         // Período de Média Móvel 90
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;// Moving Average Timeframe 
   bool              trigger_Moving_Average15     = true;       //======================== 
   int               trade_Period_Moving_Average15= 90;         // Período de Média Móvel 90
//input ENUM_TIMEFRAMES TF                              = PERIOD_CURRENT;//Moving Average Timeframe
//==============================================================================================
//sinput   string            t_trigger3                   = "TRIGGER MANAGEMENT";//CANDLE DIRECTION
   bool              trigger_Candle_Direction     = true;        // Use a direção da vela
//==============================================================================================
//sinput   string            t_trigger4                   = "TRIGGER MANAGEMENT";//CCI
   bool              UseCCI1                      = false;       // Use CCI TF 30
   int               trade_Period_CCI1            = 14;          // CCI Periodo
   double            trigger_CCI_CloseBuy1_21     = -100;         // Nível de Compra CCI
   double            trigger_CCI_CloseSell1_21    = 100;        // Nível de Venda CCI
   bool              UseCCI2                      = false;       // Use CCI TF H1
   int               trade_Period_CCI2            = 14;          // CCI Periodo
   double            trigger_CCI_CloseBuy1_22     = -100;         // Nível de Compra CCI
   double            trigger_CCI_CloseSell1_22    = 100;        // Nível de Venda CCI
   bool              UseCCI3                      = false;       // Use CCI TH H4
   int               trade_Period_CCI3            = 14;          // CCI Periodo
   double            trigger_CCI_CloseBuy1_23     = -100;         // Nível de Compra CCI
   double            trigger_CCI_CloseSell1_23    = 100;        // Nível de Venda CCI 
//==============================================================================================
//sinput   string            t_trigger5                   = "TRIGGER MANAGEMENT";//RSI
   bool              UseRSI1                      = false;       // Use RSI M30
   int               trade_Period_RSI1            = 14;          // RSI Periodo 
   bool              UseRSI2                      = false;       // Use RSI H1
   int               trade_Period_RSI2            = 14;          // RSI Periodo 
   bool              UseRSI3                      = false;       // Use RSI H4
   int               trade_Period_RSI3            = 14;          // RSI Periodo
//==============================================================================================
//sinput   string            t_trigger6                   = "TRIGGER MANAGEMENT";//MACD 
   bool              trigger_MACD1                = false;       // MACD TF M30
//extern string            TimeFrames                   = "M1;M5;M15;M30;H1;H4;D1;W1;MN";// Time frames to use (separated by ";" in the list)
   int               FastPeriod                   = 9;           // Fast EMA Period
   int               SlowPeriod                   = 12;          // Slow EMA Period
   int               SignPeriod                   = 26;          // Signal SMA Period
                     ENUM_APPLIED_PRICE Price     = PRICE_OPEN;  // MACD price
   int               BarToTest                    = 0;           // Bar to test
//--- indicator buffers
   double            ExtMacdBuffer[];
   double            ExtSignalBuffer[];
//--- right input parameters flag
   bool              ExtParameters                = false;       //=======================
//==============================================================================================
   bool              trigger_MACD2                = false;       // MACD TF H1
//extern string            TimeFrames                   = "M1;M5;M15;M30;H1;H4;D1;W1;MN"; // Time frames to use (separated by ";" in the list)
   int               FastPeriod1                  = 9;           // Fast EMA Period
   int               SlowPeriod1                  = 12;          // Slow EMA Period
   int               SignPeriod1                  = 26;          // Signal SMA Period
                     ENUM_APPLIED_PRICE Price1    = PRICE_OPEN;  // MACD price
   int               BarToTest1                   = 0;           // Bar to test
//--- indicator buffers
   double            ExtMacdBuffer1[];
   double            ExtSignalBuffer1[];
//--- right input parameters flag
   bool              ExtParameters1                                = false;       //=======================
//==============================================================================================
   bool              trigger_MACD3                = false;       // MACD TF H4
//extern string TimeFrames                              = "M1;M5;M15;M30;H1;H4;D1;W1;MN"; // Time frames to use (separated by ";" in the list)
   int               FastPeriod2                  = 9;           // Fast EMA Period
   int               SlowPeriod2                  = 12;          // Slow EMA Period
   int               SignPeriod2                  = 26;          // Signal SMA Period
                     ENUM_APPLIED_PRICE Price2    = PRICE_OPEN;  // MACD price
   int               BarToTest2                   = 0;           // Bar to test
//--- indicator buffers
   double            ExtMacdBuffer2[];
   double            ExtSignalBuffer2[];
//--- right input parameters flag
   bool              ExtParameters2                                = false;       //=======================
//==============================================================================================
   /*sinput*/   string   t_basket                     = "BASKET MANAGEMENT"; //LOTES/STOPLOOS/TAKE PROFIT
//sinput double              lot                          = 0.10;        //Lote
//---
   /*extern*/ double     lot                          = 0.10;               // Fixed lot size 0.00
   /*extern*/ double     lotStep                      = 0.01;               // Lot size (0.01)
//---
   int               MaxTrades                    = 1;           // Maximo de trades por par
   int               MaxTotalTrades               = 0;                  // Max total trades overall
   double            MaxSpread                    = 5.0;                // Max Spread Allowe
   int               Basket_Target                = 0;                  // Basket Take Profit in $
   int               Basket_StopLoss              = 0;                  // Basket Stop Lloss in $

   int               Piptp                        = 30;           // Takeprofit em pips 
   /*extern*/ double     PiptpStep                    = 10;
   int               Pipsl                        = 30;           // Stoploss em pips 
   /*extern*/ double     PipslStep                    = 10;
   double            BasketP1                     = 0.0;                // At profit 1
   double            BasketL1                     = 0.0;                // Lock 1
   double            BasketP2                     = 0.0;                // At profit 2
   double            BasketL2                     = 0.0;                // Lock 2
   double            BasketP3                     = 0.0;                // At profit 3
   double            BasketL3                     = 0.0;                // Lock 3
   double            BasketP4                     = 0.0;                // At profit 4
   double            BasketL4                     = 0.0;                // Lock 4
   double            BasketP5                     = 0.0;                // At profit 5
   double            BasketL5                     = 0.0;                // Lock 5
   double            BasketP6                     = 0.0;                // At profit 6
   double            BasketL6                     = 0.0;                // Lock 6
   bool              TrailLastLock                = false;               // Trilhar o último bloqueio definido
   double            TrailDistance                = 0.0;                // A distância da trilha 0 significa o último bloqueio
   int               StopProfit                   = 0;                  // Pare depois de tantas cestas lucrativas

   double            Adr1tp                       = 0;                // Takeprofit percent adr(10) 0=None
// double              Adr1tpStep                      = 100;
   double            Adr1sl                       = 0;                // Stoploss adr percent adr(10) 0 = None
// double              Adr1slStep                      = 100;
   int               StopLoss                     = 0;                  // Pare depois de tantas cestas perdidas
   bool              OnlyAddProfit                = false;               // Apenas adiciona negócios no lucro
   bool              CloseAllSession              = false;              // Feche todas as negociações após a(s) sessão(ões)
//==============================================================================================
   string            t_time                       = "TIME MANAGEMENT";  //SESSÕES
   bool              UseSession1                  = true;              //AUD
   string            sess1start                   = "12:01";            //Inicio 13:01
   string            sess1end                     = "15:59";            //Fim 16:59
   string            sess1comment                 = "HFT Illusion -AUD";//AUD
//============================================================================================== 
   bool              UseSession2                  = true;              //NZD
   string            sess2start                   = "16:01";            //Inicio 17:01
   string            sess2end                     = "19:59";            //Fim 20:59
   string            sess2comment                 = "HFT Illusion -NZD"; //NZD
//============================================================================================== 
   bool              UseSession3                  = true;               //JPY
   string            sess3start                   = "20:01";            //Inicio 21:01
   string            sess3end                     = "23:59";            //Fim 23:59 / 00:59
   string            sess3comment                 = "HFT Illusion -JPY"; //JPY
//==============================================================================================
   bool              UseSession4                  = true;              //CHF
   string            sess4start                   = "00:01";            //Inicio 01:01
   string            sess4end                     = "03:59";            //Fim 04:59
   string            sess4comment                 = "HFT Illusion -CHF"; //CHF
//==============================================================================================
   bool              UseSession5                  = true;               //EUR/GBP
   string            sess5start                   = "04:01";            //Inicio 05:01
   string            sess5end                     = "07:59";            //Fim 08:59
   string            sess5comment                 = "HFT Illusion -EUR/GBP"; //EUR/GBP
//==============================================================================================
   bool              UseSession6                  = true;               //USD/CAD
   string            sess6start                   = "08:01";            //Inicio 09:01
   string            sess6end                     = "11:59";            //Fim 12:59
   string            sess6comment                 = "HFT Illusion -USD/CAD"; //USD/CAD 
//==============================================================================================
   string            t_chart                      = "CHART MANAGEMENT"; //=======================
   ENUM_TIMEFRAMES   TimeFrame                    = 30;                 //TimeFrame para abrir Grafico
   string            usertemplate                 = "Default";     //HFT Illusion
   int               x_axis                       = -45;                  //Ajustar para esquerda/direita
   int               y_axis                       = -20;                  //Ajustar para cima/baixo
//==============================================================================================
int BeforeMin = 1440;
int FontSize = 8;
string FontName = "Arial";
int ShiftX = 0;
int ShiftY = 0;
int Corner = 0;

//LOTE PAINEL
string button_increase_lot = "INCREASE LOT";
string button_decrease_lot = "DECREASE LOT";
//---
string button_increase_Piptp = "INCREASE STOPTP";
string button_decrease_Piptp = "DECREASE STOPTP";
string button_increase_Pipsl = "INCREASE STOPSL";
string button_decrease_Pipsl = "DECREASE STOPSL";

string button_enable_basket_lock="ENABLE BASKET LOCK";
string button_enable_basket_tp = "ENABLE BASKET TP";
string button_enable_basket_sl = "ENABLE BASKET SL";
//---
string button_increase_Adr1tp = "INCREASE ADRSTOPTP";
string button_decrease_Adr1tp = "DECREASE ADRSTOPTP";
string button_increase_Adr1sl = "INCREASE ADRSTOPSL";
string button_decrease_Adr1sl = "DECREASE ADRSTOPSL";


//LOTE PAINEL
//PAINEL LOTES
//buttons for Single and Basket trade inputs
string button_SB1 = "btn_SB_lot_input1";
string button_SB2 = "btn_SB_lot_input2";
string button_SB3 = "btn_SB_lot_input3";
string button_SB4 = "btn_SB_lot_input4";
string button_SB5 = "btn_SB_lot_input5";
string button_SB6 = "btn_SB_lot_input6";
string button_SB7 = "btn_SB_lot_input7";
string button_SB8 = "btn_SB_lot_input8";
string button_SB9 = "btn_SB_TP_input9";
string button_SB10 = "btn_SB_TP_input10";
string button_SB11 = "btn_SB_TP_input11";
string button_SB12 = "btn_SB_TP_input12";

//buttons for HARE trade inputs
string button_H1 = "btn_H_lot_input1";
string button_H2 = "btn_H_lot_input2";
string button_H3 = "btn_H_lot_input3";
string button_H4 = "btn_H_lot_input4";
string button_H5 = "btn_H_lot_input5";
string button_H6 = "btn_H_lot_input6";
string button_H7 = "btn_H_lot_input7";
string button_H8 = "btn_H_lot_input8";
string button_H9 = "btn_H_TP_input9";
string button_H10 = "btn_H_TP_input10";
string button_H11 = "btn_H_TP_input11";
string button_H12 = "btn_H_TP_input12";

//buttons for TORTOISE trade inputs
string button_T1 = "btn_T_lot_input1";
string button_T2 = "btn_T_lot_input2";
string button_T3 = "btn_T_lot_input3";
string button_T4 = "btn_T_lot_input4";
string button_T5 = "btn_T_lot_input5";
string button_T6 = "btn_T_lot_input6";
string button_T7 = "btn_T_lot_input7";
string button_T8 = "btn_T_lot_input8";
string button_T9 = "btn_T_TP_input9";
string button_T10 = "btn_T_TP_input10";
string button_T11 = "btn_T_TP_input11";
string button_T12 = "btn_T_TP_input12";

int S_BS_TP=0.0,S_BS_SL=0.0,H_TP=0.0,H_SL=0.0,TOR_TP=0.0,TOR_SL=0.0;
double S_BS_Lot=0.01,H_Lot=0.01,TOR_Lot=0.01;
string temp_lot="";
string temp_lotc="";
//PAINEL LOTES
string button_close_basket_All = "btn_Close ALL"; 
string button_close_basket_Prof = "btn_Close Prof";
string button_close_basket_Loss = "btn_Close Loss";

string button_reset_ea = "RESET EA";
 
string button_EUR_basket = "EUR_BASKET"; 
string button_EUR_basket_buy = "EUR_BASKET_BUY";
string button_EUR_basket_sell = "EUR_BASKET_SELL";
string button_EUR_basket_close = "EUR_BASKET_CLOSE";

string button_GBP_basket = "GBP_BASKET"; 
string button_GBP_basket_buy = "GBP_BASKET_BUY";
string button_GBP_basket_sell = "GBP_BASKET_SELL";
string button_GBP_basket_close = "GBP_BASKET_CLOSE";

string button_CHF_basket = "CHF_BASKET"; 
string button_CHF_basket_buy = "CHF_BASKET_BUY";
string button_CHF_basket_sell = "CHF_BASKET_SELL";
string button_CHF_basket_close = "CHF_BASKET_CLOSE";

string button_USD_basket = "USD_BASKET"; 
string button_USD_basket_buy = "USD_BASKET_BUY";
string button_USD_basket_sell = "USD_BASKET_SELL";
string button_USD_basket_close = "USD_BASKET_CLOSE";

string button_CAD_basket = "CAD_BASKET"; 
string button_CAD_basket_buy = "CAD_BASKET_BUY";
string button_CAD_basket_sell = "CAD_BASKET_SELL";
string button_CAD_basket_close = "CAD_BASKET_CLOSE";

string button_NZD_basket = "NZD_BASKET"; 
string button_NZD_basket_buy = "NZD_BASKET_BUY";
string button_NZD_basket_sell = "NZD_BASKET_SELL";
string button_NZD_basket_close = "NZD_BASKET_CLOSE";

string button_AUD_basket = "AUD_BASKET"; 
string button_AUD_basket_buy = "AUD_BASKET_BUY";
string button_AUD_basket_sell = "AUD_BASKET_SELL";
string button_AUD_basket_close = "AUD_BASKET_CLOSE";

string button_JPY_basket = "JPY_BASKET"; 
string button_JPY_basket_buy = "JPY_BASKET_BUY";
string button_JPY_basket_sell = "JPY_BASKET_SELL";
string button_JPY_basket_close = "JPY_BASKET_CLOSE";

struct Pair 
{
  string symbol;
  string symbol1;
  double pairpip;
  double pairpip1;
  double pips;
  double pips1;
  double spread;
  double spread1;
  double hi;
  double hi1;
  double lo;
  double lo1;
  double open;
  double open1;
  double close;
  double close1;
  double point;
  double point1;
  double lots;
  double ask;
  double ask1;
  double bid;
  double bid1;
  double range;
  double range1;
  double ratio;
  double ratio1;
  double calc;
  double calc1;
  int pipsfactor;
  int pipsfactor1;
   
  };
string DefaultPairs[] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD","CADCHF","CADJPY","CHFJPY","EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD","GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD","NZDCAD","NZDCHF","NZDJPY","NZDUSD","USDCAD","USDCHF","USDJPY"};
string TradePairs[];
string curr[8] = {"USD","EUR","GBP","JPY","AUD","NZD","CAD","CHF"}; 
string postfix=StringSubstr(Symbol(),6,10);
string tempsym = "";
string EUR[7] = {"EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD"};
string GBP[6] = {"GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD"};
string GBP_R[1] = {"EURGBP"};
string CHF[1] = {"CHFJPY"};
string CHF_R[6] = {"AUDCHF","CADCHF","EURCHF","GBPCHF","NZDCHF","USDCHF"};
string USD[3] = {"USDCAD","USDCHF","USDJPY"};
string USD_R[4] = {"AUDUSD","EURUSD","GBPUSD","NZDUSD"};
string CAD[2] = {"CADCHF","CADJPY"};
string CAD_R[5] = {"AUDCAD","EURCAD","GBPCAD","NZDCAD","USDCAD"};
string NZD[4] = {"NZDCAD","NZDCHF","NZDJPY","NZDUSD"};
string NZD_R[3] = {"AUDNZD","EURNZD","GBPNZD"};
string AUD[5] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD"};
string AUD_R[2] = {"EURAUD","GBPAUD"};
string JPY_R[7] = {"AUDJPY","CADJPY","CHFJPY","EURJPY","GBPJPY","NZDJPY","USDJPY"};

string DefaultPairs1[] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD","CADCHF","CADJPY","CHFJPY","EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD","GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD","NZDCAD","NZDCHF","NZDJPY","NZDUSD","USDCAD","USDCHF","USDJPY"};
string TradePairs1[];
string curr1[8] = {"USD","EUR","GBP","JPY","AUD","NZD","CAD","CHF"};
string postfix1=StringSubstr(Symbol(),6,10);
string tempsym1 = ""; 
/*string EUR1[7] = {"EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD"};
string GBP1[6] = {"GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD"};
string GBP1_R[1] = {"EURGBP"};
string CHF1[1] = {"CHFJPY"};
string CHF1_R[6] = {"AUDCHF","CADCHF","EURCHF","GBPCHF","NZDCHF","USDCHF"};
string USD1[3] = {"USDCAD","USDCHF","USDJPY"};
string USD1_R[4] = {"AUDUSD","EURUSD","GBPUSD","NZDUSD"};
string CAD1[2] = {"CADCHF","CADJPY"};
string CAD1_R[5] = {"AUDCAD","EURCAD","GBPCAD","NZDCAD","USDCAD"};
string NZD1[4] = {"NZDCAD","NZDCHF","NZDJPY","NZDUSD"};
string NZD1_R[3] = {"AUDNZD","EURNZD","GBPNZD"};
string AUD1[5] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD"};
string AUD1_R[2] = {"EURAUD","GBPAUD"};
string JPY1_R[7] = {"AUDJPY","CADJPY","CHFJPY","EURJPY","GBPJPY","NZDJPY","USDJPY"};*/


string   _font="Consolas";

struct pairinf{
  double PairPip;
  double PairPip1;
  int pipsfactor;
  int pipsfactor1;
  double Pips;
  double Pips1;
  double PipsSig;
  double PipsSig1;
  double Pipsprev;
  double Pipsprev1;
  double Spread;
  double Spread1;
  double point;
  double point1;
  int lastSignal;
  int lastSignal1;
  int    base;
  int    base1;
  int    quote;
  int    quote1;  
}; pairinf pairinfo[];

#define NONE 0
#define DOWN -1
#define UP 1

#define NOTHING 0
#define BUY 1
#define SELL 2

struct signal
  { 
  string symbol;
  string symbol1;
  double range;
  double range1;
  double ratio;
  double ratio1;
  double bidratio;
  double bidratio1;
  double fact;
  double fact1;
  double strength;
  double strength11;
  double strength_old;
  double strength_old1;
  double strength1;//
  double strength2;//
  double calc;
  double calc1;
  double strength3;//
  double strength4;//
  double strength5;//
  double strength6;//
  double strength7;//
  double strength8;//
  double strength_Gap;//
  double hi;
  double hi1;
  double lo;
  double lo1;
  double prevratio;
  double prevratio1;   
  double prevbid;
  double prevbid1;   
  int    shift;
  int    shift1;
  double open;
  double open1;
  double close;
  double close1;
  double bid;
  double bid1;
  double point;
  double point1;  
  double Signalperc;
  double Signalperc1;
  double Signalperc2;
  double Signalperc3;
  double Signalperc4;    
  double SigRatio;
  double SigRatio1;
  double SigRelStr;
  double SigRelStr1;
  double SigBSRatio;
  double SigBSRatio1;     
  double SigCRS;
  double SigCRS1;
  double SigGap;
  double SigGap1;
  double SigGapPrev;
  double SigGapPrev1;
  double SigRatioPrev;
  double SigRatioPrev1;
  //MEDIAS MOVEIS UP/DOW  
  double SignalM01up;
  double SignalM01dn;
  double SignalM02up;
  double SignalM02dn;
  double SignalM03up;
  double SignalM03dn;
  double SignalM04up;
  double SignalM04dn;
  double SignalM05up;
  double SignalM05dn;
  double SignalM06up;
  double SignalM06dn;
  double SignalM07up;
  double SignalM07dn;
  double SignalM08up;
  double SignalM08dn;
  double SignalM09up;
  double SignalM09dn;
  double SignalM10up;
  double SignalM10dn;
  double SignalM11up;
  double SignalM11dn;
  double SignalM12up;
  double SignalM12dn;
  double SignalM13up;
  double SignalM13dn;
  double SignalM14up;
  double SignalM14dn;
  double SignalM15up;
  double SignalM15dn;
  double SignalM16up;
  double SignalM16dn;
  double SignalM17up;
  double SignalM17dn;
  double SignalM18up;
  double SignalM18dn;
  double SignalM19up;
  double SignalM19dn;
  double SignalM20up;
  double SignalM20dn;
  double SignalM21up;
  double SignalM21dn;
  double SignalM22up;
  double SignalM22dn;
  double SignalM23up;
  double SignalM23dn;
  double SignalM24up;
  double SignalM24dn;
  double SignalM25up;
  double SignalM25dn;
  double SignalM26up;
  double SignalM26dn;
  double SignalM27up;
  double SignalM27dn;
  double SignalM28up;
  double SignalM28dn;
  double SignalM29up;
  double SignalM29dn;
  double SignalM30up;
  double SignalM30dn;
//--MM
  double Signalmaup1;
  double Signalmadn1;
  double Signalmaup2;
  double Signalmadn2;
  double Signalmaup3;
  double Signalmadn3;
  double Signalmaup4;
  double Signalmadn4;
  double Signalmaup5;
  double Signalmadn5;
  double Signalmaup6;
  double Signalmadn6;
  double Signalmaup7;
  double Signalmadn7;
  double Signalmaup8;
  double Signalmadn8;
  double Signalmaup9;
  double Signalmadn9;
  double Signalmaup10;
  double Signalmadn10;
  double Signalmaup11;
  double Signalmadn11;
  double Signalmaup12;
  double Signalmadn12;
  double Signalmaup13;
  double Signalmadn13;
  double Signalmaup14;
  double Signalmadn14;
  double Signalmaup15;
  double Signalmadn15;
//--MM 
  double prevSignalusd;
  double Signalusd;
  //CANDLE DIRECTION
  double SignalCDm1;
  double SignalCDm5;
  double SignalCDm15;
  double SignalCDm30;
  double SignalCDh1;
  double SignalCDh4;
  //double SignalCDd1;
  //double SignalCDw1;
  //double SignalCDmn;
  double Signaldirup;
  double Signaldirdn;
  //CCI
  double Signalcci;
  double Signalcci1;
  double Signalcci2;
  double Signalcci3;
  double Signalcciup1;
  double Signalccidn1;
  double Signalcciup2;
  double Signalccidn2;
  double Signalcciup3;
  double Signalccidn3;
  //RSI   
  double Signalrsi;
  double Signalrsi1;
  double Signalrsi2;
  double Signalrsi3;
  double Signalrsiup1;
  double Signalrsidn1;
  double Signalrsiup2;
  double Signalrsidn2;
  double Signalrsiup3;
  double Signalrsidn3;
  //MACD
  double SignalMACDup01;
  double SignalMACDdn01;
  double SignalMACDup02;
  double SignalMACDdn02;
  double SignalMACDup03;
  double SignalMACDdn03;
  //HI-LO ASK BID
  double high1;
  double low1;
  double ask1;
  double range2;
  //double bid;
  int    digit1;
  //HI-LO ASK BID 
  //SIGNAL USD
  //double Signalusd;
  //double Signaldirup;
  //double Signaldirdn;
  //double prevSignalusd;
  double Signalm1;
  double Signalm5;
  double Signalm15;
  double Signalm30;
  double Signalh1;
  double Signalh4;
  double Signald1;
  double Signalw1;
  double Signalmn;
  double buystrength;
  double sellstrength;
   //SIGNAL USD       
  };
signal signals[];
double totalbuystrength,totalsellstrength;
struct currency 
  {
  string            curr;
  string            curr1;
  double            strength;
  double            strength11;
  double            prevstrength;
  double            prevstrength1;
  double            crs;
  double            crs1;
  int               sync;
  int               sync1;
  datetime          lastbar;
  datetime          lastbar1;
  }
; currency currencies[8];

//double totalbuystrength,totalsellstrength;
double totalbuystrength1,totalsellstrength1;
color ProfitColor,ProfitColor1,ProfitColor2,ProfitColor3,PipsColor,LotColor,LotColor1,OrdColor,OrdColor1,Color,Color1,Color2,Color3,Color4,Color5,Color6,Color7,Color8,Color9,Color10,
      Color11,Color12;
color BackGrnCol =C'20,20,20';
color LineColor=clrBlack;
color TextColor=clrBlack;

struct adrval {
  double adr;
  double adr1;
  double adr5;
  double adr10;
  double adr20;
}; adrval adrvalues[];

double totalprofit,totallots;

datetime s1start,s2start,s3start,s4start,s5start,s6start;
datetime s1end,s2end,s3end,s4end,s5end,s6end;

string comment;
int strper = PERIOD_W1;
int profitbaskets = 0;
int lossbaskets = 0;
int ticket;
//color  tradeColor,LineColor;//---
int orders  = 0;
double blots[28],slots[28],bprofit[28],sprofit[28],tprofit[28],bpos[28],spos[28];
Pair list[];//---
bool CloseAll;
//string postfix=StringSubstr(Symbol(),6,10);
int symb_cnt=0;
int symb_cnt1=0;
int period1[]= {1,5,15,30,60,240,1440,10080};
double factor;
double factor1;
int labelcolor,labelcolor1,labelcolor2=clrNONE,labelcolor3,labelcolor4,labelcolor5,labelcolor6,labelcolor7,
    labelcolor8,labelcolor9,labelcolor10,labelcolor11; 
double GetBalanceSymbol,SymbolMaxDD,SymbolMaxHi;
double PercentFloatingSymbol=0;
double PercentMaxDDSymbol=0;
datetime newday=0;
datetime newm1=0; 
bool Accending=true;
/* HP */
int localday = 99;
bool s1active = false;
bool s2active = false;
bool s3active = false;
bool s4active = false;
bool s5active = false;
bool s6active = false;
MqlDateTime sess;
string strspl[];
double currentlock = 0.0;
bool trailstarted = false;
double lockdistance = 0.0;
int totaltrades = 0;
int maxtotaltrades=0;
double stoploss;
double takeprofit;
double currstrength[8];
double currstrength1[8];
double prevstrength[8];
double prevstrength1[8];
//string Sig[28],Sell;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {   
                  
  if (UseDefaultPairs == true)
  ArrayCopy(DefaultPairs,DefaultPairs);
  else
  StringSplit(OwnPairs,',',DefaultPairs);
   
  for (int i=0;i<8;i++)
  currencies[i].curr = curr[i]; 

  if (ArraySize(DefaultPairs) <= 0) 
  {
  Print("No pairs to trade");
  return(INIT_FAILED);
  }
   
  ArrayResize(adrvalues,ArraySize(DefaultPairs));
  ArrayResize(signals,ArraySize(DefaultPairs));
  ArrayResize(pairinfo,ArraySize(DefaultPairs));
  
  for(int i=0;i<ArraySize(DefaultPairs);i++)//---        
  //for(int i=0;i<ArraySize(DefaultPairs);i++)
  {
  DefaultPairs[i]=DefaultPairs[i]+postfix;//---
  //DefaultPairs[i]=DefaultPairs[i]+postfix;    
  }//---
  ArrayResize(list,ArraySize(DefaultPairs));//---
  
  for(int i=0; i<ArraySize(list); i++)//---
  {//---
  pairinfo[i].base = StringSubstr(DefaultPairs[i],0,3);
  pairinfo[i].quote = StringSubstr(DefaultPairs[i],3,0);
   
  if (MarketInfo(DefaultPairs[i] ,MODE_DIGITS) == 4 || MarketInfo(DefaultPairs[i] ,MODE_DIGITS) == 2)
  {
  pairinfo[i].PairPip = MarketInfo(DefaultPairs[i] ,MODE_POINT);
  pairinfo[i].pipsfactor = 1;
  } 
  else
  { 
  pairinfo[i].PairPip = MarketInfo(DefaultPairs[i] ,MODE_POINT)*10;
  pairinfo[i].pipsfactor = 10;
  }
       
  //SetPanel("BarSupMeter",0,x_axis,y_axis-30,1098,30,clrDarkSlateGray,C'61,61,61',1);                
  //SetPanel("Bar",0,x_axis,y_axis,1098,450,C'30,30,30',C'61,61,61',1);
  //SetPanel("Panel",0,x_axis+585,y_axis+13,170,150,C'30,30,30',C'61,61,61',1);
  //SetPanel("BottPanel",0,x_axis+405,y_axis+450,602,77,C'30,30,30',clrWhite,1);
  //SetPanel("Spread"+IntegerToString(i),0,x_axis+170,(i*16)+y_axis+200,30,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES
  //SetPanel("Pips"+IntegerToString(i),0,x_axis+200,(i*16)+y_axis+200,40,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES
  //SetPanel("Adr"+IntegerToString(i),0,x_axis+230,(i*16)+y_axis+200,30,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES
  //SetPanel("BidRatio"+IntegerToString(i),0,x_axis+260,(i*16)+y_axis+200,55,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES
  //SetPanel("RelStr"+IntegerToString(i),0,x_axis+315,(i*16)+y_axis+200,20,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES
  //SetPanel("BSRatio"+IntegerToString(i),0,x_axis+335,(i*16)+y_axis+200,25,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES
  //SetPanel("PrevGAP"+IntegerToString(i),0,x_axis+360,(i*16)+y_axis+200,30,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES
  //SetPanel("GAP123"+IntegerToString(i),0,x_axis+390,(i*16)+y_axis+200,45,17,clrBlack,C'61,61,61',1);//LINHAS INDICADORES         
  SetPanel("HM1"+IntegerToString(i),0,x_axis+660,(i*15)+y_axis+234,30,12,BackGrnCol,clrDimGray,1);
  SetPanel("HM2"+IntegerToString(i),0,x_axis+690,(i*15)+y_axis+234,30,12,BackGrnCol,clrDimGray,1);
  SetPanel("HM3"+IntegerToString(i),0,x_axis+720,(i*15)+y_axis+234,30,12,BackGrnCol,clrDimGray,1);
  SetPanel("HM4"+IntegerToString(i),0,x_axis+750,(i*15)+y_axis+234,30,12,BackGrnCol,clrDimGray,1);
  SetPanel("HM5"+IntegerToString(i),0,x_axis+780,(i*15)+y_axis+234,30,12,BackGrnCol,clrDimGray,1);  
  //SetPanel("TP",0,x_axis+235,y_axis+413,90,20,Black,White,1);//CAIXA BRANCA GAIN/LOOS
  //SetPanel("TP1",0,x_axis+1,y_axis+10,578,160,Black,White,1);//CAIXA BRANCA GESTAO DE RISCO
  //SetPanel("TP2",0,x_axis+420,y_axis+10,158,25,Black,White,1);//CAIXA BRANCA BASKET TAKEPROFIT
  //SetPanel("TP3",0,x_axis+420,y_axis+145,158,25,Black,White,1);//CAIXA BRANCA BASKET STOPLOOS
  //SetPanel("TP4",0,x_axis+420,y_axis+35,138,20,Black,White,1);//CAIXA BRANCA
  //SetPanel("TP5",0,x_axis+420,y_axis+125,138,20,Black,White,1);//CAIXA BRANCA
  //SetPanel("TP6",0,x_axis+420,y_axis+54,158,20,Black,White,1);//CAIXA BRANCA
  //SetPanel("TP10",0,x_axis+420,y_axis+105,158,20,Black,White,1);//CAIXA BRANCA
  //SetPanel("TP7",0,x_axis+510,y_axis+73,68,20,Black,White,1);//CAIXA BRANCA
  //SetPanel("TP8",0,x_axis+558,y_axis+35,20,20,Black,White,1);//CAIXA BRANCA
  //SetPanel("TP9",0,x_axis+558,y_axis+125,20,20,Black,White,1);//CAIXA BRANCA
  SetPanel("TP100",0,x_axis+46,y_axis+234,165,419,Black,Yellow,1);//CAIXA AMARELA
  SetPanel("TP110",0,x_axis+211,y_axis+234,190,419,Black,Yellow,1);//CAIXA AMARELA
  SetPanel("TP120",0,x_axis+1234,y_axis+233,112,419,Black,Yellow,1);//CAIXA AMARELA
  //SetPanel("B01"+IntegerToString(i),0,x_axis+610,(i*16)+y_axis+200,20,17,clrBlack,clrDimGray,1);//CAIXA VAZIA
  SetPanel("B02"+IntegerToString(i),0,x_axis+1235,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA LOTES
  SetPanel("B03"+IntegerToString(i),0,x_axis+1265,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA LOTES
  SetPanel("B04"+IntegerToString(i),0,x_axis+1305,(i*15)+y_axis+234,40,12,clrBlack,clrDimGray,1);//CAIXA LOTES
  SetPanel("B07"+IntegerToString(i),0,x_axis+450,(i*15)+y_axis+234,25,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION           
  SetPanel("B08"+IntegerToString(i),0,x_axis+475,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION                        
  SetPanel("A01"+IntegerToString(i),0,x_axis+500,(i*15)+y_axis+234,25,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION
  SetPanel("A02"+IntegerToString(i),0,x_axis+520,(i*15)+y_axis+234,50,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION           
  SetPanel("A03"+IntegerToString(i),0,x_axis+565,(i*15)+y_axis+234,25,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION     
  SetPanel("A04"+IntegerToString(i),0,x_axis+590,(i*15)+y_axis+234,15,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION
  SetPanel("A05"+IntegerToString(i),0,x_axis+600,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION
  SetPanel("A06"+IntegerToString(i),0,x_axis+630,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA PRICE ACTION
  SetPanel("B05"+IntegerToString(i),0,x_axis+810,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA MEDIAS MOVEIS
  SetPanel("B06"+IntegerToString(i),0,x_axis+840,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA MEDIAS MOVEIS
  SetPanel("A07"+IntegerToString(i),0,x_axis+870,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA MEDIAS MOVEIS     
  SetPanel("A08"+IntegerToString(i),0,x_axis+900,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA MEDIAS MOVEIS
  SetPanel("A10"+IntegerToString(i),0,x_axis+930,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA MEDIAS MOVEIS
  SetPanel("A11"+IntegerToString(i),0,x_axis+960,(i*15)+y_axis+234,30,12,clrBlack,clrDimGray,1);//CAIXA CANDLE DIRECTION
  
  //SetPanel("High"+IntegerToString(i),0,x_axis+990,(i*15)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0); 
  //SetPanel("Ask"+IntegerToString(i),0,x_axis+1025,(i*15)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0);        
  //SetPanel("Bid"+IntegerToString(i),0,x_axis+1060,(i*15)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0);
  //SetPanel("Low"+IntegerToString(i),0,x_axis+1095,(i*15)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0);
  //SetPanel("PointRange"+IntegerToString(i),0,x_axis+1130,(i*15)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0);
  
  SetPanel("A1"+IntegerToString(i),0,x_axis+1112,(i*15)+y_axis+234,30,12,C'0,0,0',C'0,0,0',1);
  SetPanel("A2"+IntegerToString(i),0,x_axis+1112,(i*15)+y_axis+234,30,12,C'0,0,0',C'0,0,0',1);            
  SetPanel("B11"+IntegerToString(i),0,x_axis+1112,(i*15)+y_axis+234,3,12,C'0,0,0',C'0,0,0',1); 
  SetPanel("B21"+IntegerToString(i),0,x_axis+1114,(i*15)+y_axis+234,3,12,C'0,0,0',C'0,0,0',1); 
  SetPanel("B31"+IntegerToString(i),0,x_axis+1116,(i*15)+y_axis+234,3,12,labelcolor4,labelcolor2,1);
  SetPanel("B41"+IntegerToString(i),0,x_axis+1118,(i*15)+y_axis+234,3,12,labelcolor5,labelcolor2,1);
  SetPanel("B51"+IntegerToString(i),0,x_axis+1120,(i*15)+y_axis+234,3,12,labelcolor6,labelcolor2,1);
  SetPanel("B61"+IntegerToString(i),0,x_axis+1122,(i*15)+y_axis+234,3,12,labelcolor7,labelcolor2,1);
  SetPanel("B71"+IntegerToString(i),0,x_axis+1124,(i*15)+y_axis+234,3,12,labelcolor8,labelcolor2,1);
  SetPanel("B81"+IntegerToString(i),0,x_axis+1126,(i*15)+y_axis+234,3,12,labelcolor9,labelcolor2,1);
  SetPanel("B91"+IntegerToString(i),0,x_axis+1128,(i*15)+y_axis+234,3,12,labelcolor10,labelcolor2,1);
  SetPanel("B101"+IntegerToString(i),0,x_axis+1130,(i*15)+y_axis+234,3,12,labelcolor11,labelcolor2,1);
  SetPanel("DIR"+IntegerToString(i),0,x_axis+1163,(i*15)+y_axis+234,10,12,C'0,0,0',C'0,0,0',1);  
  //SetPanel("A2"+IntegerToString(i),0,x_axis+995,(i*15)+y_axis+229,315,17,C'30,30,30',C'61,61,61',1);//COR FUNDO PAINEL LOTES          
  SetPanel("A222"+IntegerToString(i),0,x_axis+475,(i*15)+y_axis+234,185,12,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  SetPanel("B2222"+IntegerToString(i),0,x_axis+475,(i*15)+y_axis+234,185,12,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  SetPanel("A2223"+IntegerToString(i),0,x_axis+810,(i*15)+y_axis+234,180,12,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  SetPanel("B22223"+IntegerToString(i),0,x_axis+810,(i*15)+y_axis+234,180,12,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  //SetPanel("Spread22"+IntegerToString(i),list[i].spread1,x_axis+5,(i*15)+y_axis+229,20,17,(list[i].spread1),C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  //SetPanel("Spread22"+IntegerToString(i),list[i].spread1,x_axis+5,(i*15)+y_axis+229,20,17,(list[i].spread1),C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE       
  //SetText("Pr1"+IntegerToString(i),list[i].symbol1,x_axis+5,(i*15)+y_axis+229,Colorstr1(list[i].ratio1),C'10,10,10',1,8);
//BOTAO LOTES
//panel box for Auto Pending Orders 
  int                             a_axis                      = -313;  // Esquerda X Direita
  int                             aa_axis                     = 205;// Cima X Baixo 
  int                             z_axis                      = -313;                
  SetPanel("H_Inputs",0,a_axis+573,aa_axis+11,95,95,clrGoldenrod,White,1);//inputs box for HARE LOTS,SL,TP
  SetText("H_In1","LOTE/STOP por PIP",a_axis+575,aa_axis+10,Black,7);
  SetText("LotSize","LotSize",a_axis+576,aa_axis+21,White,8);
  SetPanel("H_Lots_P",0,a_axis+623,aa_axis+21,40,14,clrBlack,Black,1);
  Create_Button(button_increase_lot,"+",13,13,z_axis+627,aa_axis+36,clrGainsboro,clrWhite);
  Create_Button(button_decrease_lot,"-",13,13,z_axis+645,aa_axis+36,clrGainsboro,clrWhite);
  //Create_Button(button_H3,"+",12,12,z_axis+641,aa_axis+34,clrGainsboro,clrWhite);
  //Create_Button(button_H4,"-",12,12,z_axis+655,aa_axis+34,clrGainsboro,clrWhite);
  //Create_Button(button_H5,"+",12,12,z_axis+641,aa_axis+48,clrGainsboro,clrWhite);
  //Create_Button(button_H6,"-",12,12,z_axis+655,aa_axis+48,clrGainsboro,clrWhite);         
  //Create_Button(button_H7,"+",12,12,z_axis+641,aa_axis+62,clrGainsboro,clrWhite);
  //Create_Button(button_H8,"-",12,12,z_axis+655,aa_axis+62,clrGainsboro,clrWhite);
  SetText("Piptp","TP",a_axis+581,aa_axis+76,Black,8);
  SetPanel("H_TP_P",0,a_axis+623,aa_axis+50,40,14,clrBlack,White,1);
  Create_Button(button_increase_Piptp,"+",13,13,z_axis+627,aa_axis+64,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Piptp,"-",13,13,z_axis+645,aa_axis+64,clrGainsboro,clrWhite);
  SetText("Pipsl","SL",a_axis+581,aa_axis+90,Black,8);
  SetPanel("H_SL_P",0,a_axis+623,aa_axis+78,40,14,clrBlack,White,1);
  Create_Button(button_increase_Pipsl,"+",13,13,z_axis+627,aa_axis+91,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Pipsl,"-",13,13,z_axis+645,aa_axis+91,clrGainsboro,clrWhite);
  //SetText("H_In5",DoubleToStr(H_Lot,2),a_axis+610,aa_axis+20,clrWhite,8);         
  SetText("Piptp",IntegerToString(H_TP),a_axis+576,aa_axis+50,clrWhite,8);
  SetText("Pipsl",IntegerToString(H_SL),a_axis+576,aa_axis+78,clrWhite,8);
  
//panel box for Basket Trades & Single Trades        
  SetPanel("S_BAS_Inputs",0,a_axis+573,aa_axis+332,95,95,clrGoldenrod,White,1);//inputs box for SINGLE and BASKET LOTS,SL,TP
  SetText("S_BAS_In1","STOP por ADR",a_axis+575,aa_axis+332,Black,7);
  //SetText("LotSize1","Lot",a_axis+576,aa_axis+342,White,8);
  //SetPanel("S_BAS_Lots_P",0,a_axis+623,aa_axis+341,40,14,clrBlack,White,1);
  //Create_Button(button_SB1,"+",13,13,z_axis+627,aa_axis+356,clrGainsboro,clrWhite);
  //Create_Button(button_SB2,"-",13,13,z_axis+645,aa_axis+356,clrGainsboro,clrWhite);
  //Create_Button(button_SB3,"+",12,12,z_axis+641,aa_axis+359,clrGainsboro,clrWhite);
  //Create_Button(button_SB4,"-",12,12,z_axis+655,aa_axis+359,clrGainsboro,clrWhite);
  //Create_Button(button_SB5,"+",12,12,z_axis+641,aa_axis+373,clrGainsboro,clrWhite);
  //Create_Button(button_SB6,"-",12,12,z_axis+655,aa_axis+373,clrGainsboro,clrWhite);         
  //Create_Button(button_SB7,"+",12,12,z_axis+641,aa_axis+387,clrGainsboro,clrWhite);
  //Create_Button(button_SB8,"-",12,12,z_axis+655,aa_axis+387,clrGainsboro,clrWhite);
  SetText("Adr1tp","TP",a_axis+581,aa_axis+370,Black,8);
  SetPanel("S_BAS_TP_P",0,a_axis+623,aa_axis+370,40,14,clrBlack,White,1);
  Create_Button(button_increase_Adr1tp,"+",13,13,z_axis+627,aa_axis+384,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Adr1tp,"-",13,13,z_axis+645,aa_axis+384,clrGainsboro,clrWhite);
  SetText("Adr1sl","SL",a_axis+580,aa_axis+415,Black,8);
  SetPanel("S_BS_SL_P",0,a_axis+623,aa_axis+398,40,14,clrBlack,White,1);
  Create_Button(button_increase_Adr1sl,"+",13,13,z_axis+627,aa_axis+412,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Adr1sl,"-",13,13,z_axis+645,aa_axis+412,clrGainsboro,clrWhite);
  //SetText("S_BAS_In5",DoubleToStr(S_BS_Lot,2),a_axis+610,aa_axis+345,clrWhite,8);         
  SetText("Adr1tp",IntegerToString(S_BS_TP),a_axis+576,aa_axis+370,clrWhite,8);
  SetText("Adr1sl",IntegerToString(S_BS_SL),a_axis+576,aa_axis+398,clrWhite,8);
//   
  //SetPanel("TP1",0,x_axis+122,y_axis+288,125,20,Black,White,1); //these move the "Monitoring Trade" boxes
  //SetPanel("TP2",0,x_axis+122,y_axis+307,125,20,Black,White,1);
  //SetPanel("TP3",0,x_axis+122,y_axis+326,125,20,Black,White,1);
//BOTAO LOTES         
  //SetText("Pr11"+IntegerToString(i),StringSubstr(TradePairs[i],0,6),x_axis+1000,(i*16)+y_axis+200,clrWhite,8);//BOTAO PAR COLUNA 2
  //SetText("Spr1"+IntegerToString(i),DoubleToStr(list[i].spread,1),x_axis+175,(i*16)+y_axis+200,Orange,8);//---
  SetText("Spr1"+IntegerToString(i),0,x_axis+450,(i*15)+y_axis+234,Orange,8);//TEXTO INDICADORES
  //SetText("Pp1"+IntegerToString(i),DoubleToStr(MathAbs(list[i].pips),0),x_axis+200,(i*16)+y_axis+200,ColorPips2(list[i].pips),8);//---
  SetText("Pp1"+IntegerToString(i),0,x_axis+475,(i*15)+y_axis+234,PipsColor,8);//TEXTO INDICADORES
  //SetText("RelStrgth"+IntegerToString(i),DoubleToStr(list[i].calc,0),x_axis+320,(i*16)+y_axis+200,Colorsync(list[i].calc),8); 
  //SetText("BSR"+IntegerToString(i),DoubleToStr(signals[i].strength5,1),x_axis+650,(i*16)+y_axis+200,ColorBSRat(signals[i].strength5),8);
  SetText("S1"+IntegerToString(i),0,x_axis+502,(i*15)+y_axis+234,Yellow,8);//TEXTO INDICADORES
  
  //SetText("Direct","High     Ask    Bid      Low",x_axis+991,y_axis+210,Gray,8);
  //SetText("Trend","Range",x_axis+1130,y_axis+210,Gray,8);
  //SetText("Symbol","Point",x_axis+1130,y_axis+220,Gray,8);       
         
  SetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),x_axis+1240,(i*15)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  SetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),x_axis+1270,(i*15)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  //SetText("bPos"+IntegerToString(i),DoubleToStr(bpos[i],0),x_axis+1140,(i*15)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  //SetText("sPos"+IntegerToString(i),DoubleToStr(spos[i],0),x_axis+1160,(i*15)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  //SetText("TProf"+IntegerToString(i),DoubleToStr(MathAbs(bprofit[i]),2),x_axis+1180,(i*15)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  //SetText("SProf"+IntegerToString(i),DoubleToStr(MathAbs(sprofit[i]),2),x_axis+1220,(i*15)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  SetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),x_axis+1310,(i*15)+y_axis+234,C'61,61,61',8);//TEXTO TOTAL LUCRO PAR
  SetText("TotProf",DoubleToStr(MathAbs(totalprofit),2),x_axis+325,y_axis+429,ProfitColor1,15);//TEXTO TOTAL GAISN/LOOS         
  //SetText("Highest","Highest= "+DoubleToStr(SymbolMaxHi,2)+" ("+DoubleToStr(PercentFloatingSymbol,2)+"%)",x_axis+420,y_axis+37,BullColor,8);
  //SetText("Lowest","Lowest= "+DoubleToStr(SymbolMaxDD,2)+" ("+DoubleToStr(PercentMaxDDSymbol,2)+"%)",x_axis+420,y_axis+127,BearColor,8);  
  //SetText("Lock","Lock= "+DoubleToStr(currentlock,2),x_axis+510,y_axis+76,BullColor,8);
  //SetText("Won",IntegerToString(profitbaskets,2),x_axis+559,y_axis+37,BullColor,8);
  //SetText("Lost",IntegerToString(lossbaskets,2),x_axis+559,y_axis+127,BearColor,8);

  SetText("usdintsig"+IntegerToString(i),DoubleToStr(MathAbs(signals[i].Signalusd),0)+"%",x_axis+1142,(i*15)+y_axis+234,Color9,8);
             
  //SetText("Pr1"+IntegerToString(i),list[i].symbol1,x_axis+5,(i*15)+y_axis+234,Colorstr1(list[i].ratio1),8);//---
  //SetText("Pr1"+IntegerToString(i),StringSubstr(DefaultPairs[i],0,6),x_axis+120,(i*16)+y_axis+234,clrWhite,8);//BOTAO PAR COLUNA 2
  Create_Button(IntegerToString(i)+"Pair",StringSubstr(DefaultPairs[i],0,6),50 ,12,x_axis+400 ,(i*15)+y_axis+234,clrBlack,clrWhite);
  //Create_Button(i+"Hold","~",20 ,12,x_axis+1153,(i*15)+y_axis+234,C'35,35,35',clrAqua);
  Create_Button(i+"BUY","B",20 ,12,x_axis+1173,(i*15)+y_axis+234,C'35,35,35',clrLime);           
  Create_Button(i+"SELL","S",20 ,12,x_axis+1193 ,(i*15)+y_axis+234,C'35,35,35',clrRed);
  Create_Button(i+"CLOSE","C",20 ,12,x_axis+1213,(i*15)+y_axis+234,C'35,35,35',clrYellow);
  }

  //SetText("TPr","Basket TakeProfit =$ "+DoubleToStr(Basket_Target,0),x_axis+420,y_axis+20,Yellow,8);
  //SetText("SL","Basket StopLoss =$ -"+DoubleToStr(Basket_StopLoss,0),x_axis+420,y_axis+145,Yellow,8);                 
  //SetText("Symbol","Sprd Pips   BidRatio                RStr",x_axis+55,y_axis+635,White,8);
  //SetText("Symbol2","Sprd  Pips       Adr ",x_axis+340,y_axis+635,White,8);
  //SetText("Symbol3","BidRatio   BSR  RStr  Pg Gap",x_axis+430,y_axis+635,White,8);
  //SetText("Symbol4","HeatMap",x_axis+635,y_axis+635,White,8);                
  //SetText("TTr","B.Lot     S.Lot",x_axis+1060,y_axis+635,White,8);
  //SetText("Trades","Buy Sell  Buy       Sell        Prof",x_axis+1133,y_axis+635,White,8);

/*//BOTAO LOTES
   Create_Button(button_increase_lot,CharToStr(225),15,12,x_axis+169,y_axis+437,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("LotSize","",76,12,x_axis+184,y_axis+437,C'35,35,35',clrWhite);
   Create_Button(button_decrease_lot,CharToStr(226),15,12,x_axis+260,y_axis+437,C'35,35,35',clrWhite,clrRed,"Wingdings",8); 
//BOTAO LOTES
//BOTAO STOPS
   Create_Button(button_increase_Adr1tp,CharToStr(225),15,12,x_axis+250,y_axis+331,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Adr1tp","",76,12,x_axis+265,y_axis+331,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Adr1tp,CharToStr(226),15,12,x_axis+340,y_axis+331,C'35,35,35',clrWhite,clrRed,"Wingdings",8);
   
   Create_Button(button_increase_Adr1sl,CharToStr(225),15,12,x_axis+250,y_axis+343,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Adr1sl","",76,12,x_axis+265,y_axis+343,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Adr1sl,CharToStr(226),15,12,x_axis+340,y_axis+343,C'35,35,35',clrWhite,clrRed,"Wingdings",8);   
//---    
   Create_Button(button_increase_Piptp,CharToStr(225),15,12,x_axis+250,y_axis+532,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Piptp","",76,12,x_axis+265,y_axis+532,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Piptp,CharToStr(226),15,12,x_axis+340,y_axis+532,C'35,35,35',clrWhite,clrRed,"Wingdings",8);
   
   Create_Button(button_increase_Pipsl,CharToStr(225),15,12,x_axis+250,y_axis+544,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Pipsl","",76,12,x_axis+265,y_axis+544,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Pipsl,CharToStr(226),15,12,x_axis+340,y_axis+544,C'35,35,35',clrWhite,clrRed,"Wingdings",8);
//BOTAO STOPS*/   
//Basket Trades
  int basket_x = x_axis + 215;
  int basket_y = y_axis + 345;
  int i = 0;   
//AUD
Create_Button(button_AUD_basket,"AUD",30 ,12,basket_x+0 ,basket_y+10,Black,clrWhite);//
Create_Button(button_AUD_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+10,Black,clrLime);//
Create_Button(button_AUD_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+10,Black,clrRed);//
Create_Button(button_AUD_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+10,Black,clrYellow);//
//CAD
i += 50;
Create_Button(button_CAD_basket,"CAD",30 ,12,basket_x+0 ,basket_y+25,Black,clrWhite);//
Create_Button(button_CAD_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+25,Black,clrLime);//
Create_Button(button_CAD_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+25,Black,clrRed);//
Create_Button(button_CAD_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+25,Black,clrYellow);//
//CHF
i += 50;
Create_Button(button_CHF_basket,"CHF",30 ,12,basket_x+0 ,basket_y+40,Black,clrWhite);//
Create_Button(button_CHF_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+40,Black,clrLime);//
Create_Button(button_CHF_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+40,Black,clrRed);//
Create_Button(button_CHF_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+40,Black,clrYellow);//
//EUR
i += 50;
Create_Button(button_EUR_basket,"EUR",30 ,12,basket_x+0 ,basket_y+55,Black,clrWhite);//
Create_Button(button_EUR_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+55,Black,clrLime);//
Create_Button(button_EUR_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+55,Black,clrRed);//
Create_Button(button_EUR_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+55,Black,clrYellow);//
//GBP
i += 50;
Create_Button(button_GBP_basket,"GBP",30 ,12,basket_x+0 ,basket_y+130,Black,clrWhite);//
Create_Button(button_GBP_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+130,Black,clrLime);//
Create_Button(button_GBP_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+130,Black,clrRed);//
Create_Button(button_GBP_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+130,Black,clrYellow);//
//JPY
i += 50;
Create_Button(button_JPY_basket,"JPY",30 ,12,basket_x+0 ,basket_y+145,Black,clrWhite);//
Create_Button(button_JPY_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+145,Black,clrLime);//
Create_Button(button_JPY_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+145,Black,clrRed);//
Create_Button(button_JPY_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+145,Black,clrYellow);//
//NZD
i += 50;
Create_Button(button_NZD_basket,"NZD",30 ,12,basket_x+0 ,basket_y+160,Black,clrWhite);//
Create_Button(button_NZD_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+160,Black,clrLime);//
Create_Button(button_NZD_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+160,Black,clrRed);//
Create_Button(button_NZD_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+160,Black,clrYellow);//
//USD
i += 50;
Create_Button(button_USD_basket,"USD",30 ,12,basket_x+0 ,basket_y+175,Black,clrWhite);//
Create_Button(button_USD_basket_buy,"BUY",30 ,12,basket_x+30 ,basket_y+175,Black,clrLime);//
Create_Button(button_USD_basket_sell,"SELL",30 ,12,basket_x+60 ,basket_y+175,Black,clrRed);//
Create_Button(button_USD_basket_close,"CLOSE",40 ,12,basket_x+90 ,basket_y+175,Black,clrYellow);//  
/*  //AUD
  Create_Button(button_AUD_basket,"AUD",40 ,17,basket_x+i ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_AUD_basket_buy,"BUY",40 ,17,basket_x+i ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_AUD_basket_sell,"SELL",40 ,17,basket_x+i ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_AUD_basket_close,"CLOSE",40 ,17,basket_x+i ,basket_y+51,C'35,35,35',clrOrange);
  //CAD
  i += 50;
  Create_Button(button_CAD_basket,"CAD",40 ,17,basket_x+40 ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_CAD_basket_buy,"BUY",40 ,17,basket_x+40 ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_CAD_basket_sell,"SELL",40 ,17,basket_x+40 ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_CAD_basket_close,"CLOSE",40 ,17,basket_x+40 ,basket_y+51,C'35,35,35',clrOrange);
  //CHF
  i += 50;
  Create_Button(button_CHF_basket,"CHF",40 ,17,basket_x+80 ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_CHF_basket_buy,"BUY",40 ,17,basket_x+80 ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_CHF_basket_sell,"SELL",40 ,17,basket_x+80 ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_CHF_basket_close,"CLOSE",40 ,17,basket_x+80 ,basket_y+51,C'35,35,35',clrOrange);
  //EUR
  i += 50;
  Create_Button(button_EUR_basket,"EUR",40 ,17,basket_x+120 ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_EUR_basket_buy,"BUY",40 ,17,basket_x+120 ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_EUR_basket_sell,"SELL",40 ,17,basket_x+120 ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_EUR_basket_close,"CLOSE",40 ,17,basket_x+120 ,basket_y+51,C'35,35,35',clrOrange);
  //GBP
  i += 50;
  Create_Button(button_GBP_basket,"GBP",40 ,17,basket_x+160 ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_GBP_basket_buy,"BUY",40 ,17,basket_x+160 ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_GBP_basket_sell,"SELL",40 ,17,basket_x+160 ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_GBP_basket_close,"CLOSE",40 ,17,basket_x+160 ,basket_y+51,C'35,35,35',clrOrange);
  //JPY
  i += 50;
  Create_Button(button_JPY_basket,"JPY",40 ,17,basket_x+200 ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_JPY_basket_buy,"BUY",40 ,17,basket_x+200 ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_JPY_basket_sell,"SELL",40 ,17,basket_x+200 ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_JPY_basket_close,"CLOSE",40 ,17,basket_x+200 ,basket_y+51,C'35,35,35',clrOrange);
  //NZD
  i += 50;
  Create_Button(button_NZD_basket,"NZD",40 ,17,basket_x+240 ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_NZD_basket_buy,"BUY",40 ,17,basket_x+240 ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_NZD_basket_sell,"SELL",40 ,17,basket_x+240 ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_NZD_basket_close,"CLOSE",40 ,17,basket_x+240 ,basket_y+51,C'35,35,35',clrOrange);
  //USD
  i += 50;
  Create_Button(button_USD_basket,"USD",40 ,17,basket_x+280 ,basket_y,C'35,35,35',clrWhite);
  Create_Button(button_USD_basket_buy,"BUY",40 ,17,basket_x+280 ,basket_y+17,C'35,35,35',clrLime);
  Create_Button(button_USD_basket_sell,"SELL",40 ,17,basket_x+280 ,basket_y+34,C'35,35,35',clrRed);
  Create_Button(button_USD_basket_close,"CLOSE",40 ,17,basket_x+280 ,basket_y+51,C'35,35,35',clrOrange);
*/
//BOTAO ACCOUNT MANAGER 
Create_Button("button_trigger_use_ShowProfitInfo","ShowProfitInfo",100 ,12,x_axis+5 ,y_axis+20,Black,White);//BOTAO ACCOUNT MANAGER
Create_Button("button_trigger_use_ShowTodayRanges","ShowTodayRanges",100 ,12,x_axis+105 ,y_axis+20,Black,White);//BOTAO ACCOUNT MANAGER
Create_Button("button_trigger_use_ShowRiskInfo","ShowRiskInfo",100 ,12,x_axis+205 ,y_axis+20,Black,White);//BOTAO ACCOUNT MANAGER
Create_Button("button_trigger_use_ShowAccountOrderInfo","ShowAccountOrder",100 ,12,x_axis+305 ,y_axis+20,Black,White);//BOTAO ACCOUNT MANAGER 
//BOTAO ACCOUNT MANAGER 
Create_Button("button_trigger_use_PARES1","Pares",50 ,12,x_axis+46 ,y_axis+222,Black,White);//PARES FAKE
//Create_Button("button_trigger_use_SPR1","Spr",20 ,12,x_axis+51 ,y_axis+222,Black,White);//SPR FAKE
Create_Button("button_trigger_use_Pips1","Pip",30 ,12,x_axis+96 ,y_axis+222,Black,White);//PIP FAKE
Create_Button("button_trigger_use_PriceAction","Price Action",678 ,12,x_axis+1 ,y_axis+210,Black,White);//PRICE ACTION
Create_Button("button_trigger_use_PriceAction1",".",191 ,12,x_axis+210 ,y_axis+222,Black,White);//PRICE ACTION FAKE          
Create_Button("button_trigger_use_bidratio1","Bidratio",60 ,12,x_axis+126 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_relstrength1","Str",25 ,12,x_axis+185 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_SPR","Spr",25 ,12,x_axis+450 ,y_axis+222,Black,White);//SPR FAKE
Create_Button("button_trigger_use_Pips","Pip",30 ,12,x_axis+475 ,y_axis+222,Black,White);//
Create_Button("button_trigger_use_ADR","Adr",25 ,12,x_axis+500 ,y_axis+222,Black,White);//ADR FAKE
Create_Button("button_trigger_use_bidratio","Bidratio",40 ,12,x_axis+525 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_buysellratio","B.S",25 ,12,x_axis+565 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_relstrength","Str",15 ,12,x_axis+590 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_SigGapPrev","GapP",30 ,12,x_axis+600 ,y_axis+222,Black,White);//Prev.Gap FAKE
Create_Button("button_trigger_use_gap","Gap",30 ,12,x_axis+630 ,y_axis+222,Black,White);

Create_Button("button_FAKE","Heat Map",152 ,12,x_axis+660 ,y_axis+210,Black,White);//Heat Map FAKE
Create_Button("button_trigger_UseHeatMap1","M15",32 ,12,x_axis+660 ,y_axis+222,Black,White);
Create_Button("button_trigger_UseHeatMap2","M30",30 ,12,x_axis+690 ,y_axis+222,Black,White);
Create_Button("button_trigger_UseHeatMap3","H1",30 ,12,x_axis+720 ,y_axis+222,Black,White);
Create_Button("button_trigger_UseHeatMap4","H4",30 ,12,x_axis+750 ,y_axis+222,Black,White);
Create_Button("button_trigger_UseHeatMap5","D1",30 ,12,x_axis+780 ,y_axis+222,Black,White);
   
Create_Button("button_FAKEMM12","Média Móvel",150 ,12,x_axis+810 ,y_axis+210,Black,White); //BOTAO FAKE
//MM12   
Create_Button("button_trigger_Moving_Average1",".",10 ,12,x_axis+810 ,y_axis+222,Black,White);//MM12 30
Create_Button("button_trigger_Moving_Average2",".",10 ,12,x_axis+820 ,y_axis+222,Black,White);//MM12 H1
Create_Button("button_trigger_Moving_Average3",".",10 ,12,x_axis+830 ,y_axis+222,Black,White);//MM12 H4 

//Create_Button("button_FAKEMM21","MM21",60 ,17,m_axis+510 ,n_axis+85,Black,White); //BOTAO FAKE
//MM21 
Create_Button("button_trigger_Moving_Average4",".",10 ,12,x_axis+840 ,y_axis+222,Black,White);//MM21 30
Create_Button("button_trigger_Moving_Average5",".",10 ,12,x_axis+850 ,y_axis+222,Black,White);//MM21 H1
Create_Button("button_trigger_Moving_Average6",".",10 ,12,x_axis+860 ,y_axis+222,Black,White);//MM21 H4

//Create_Button("button_FAKEMM30","MM30",60 ,17,m_axis+570 ,n_axis+60,Black,White); //BOTAO FAKE
//MM30
Create_Button("button_trigger_Moving_Average7",".",10 ,12,x_axis+870 ,y_axis+222,Black,White);//MM30 30
Create_Button("button_trigger_Moving_Average8",".",10 ,12,x_axis+880 ,y_axis+222,Black,White);//MM30 H1
Create_Button("button_trigger_Moving_Average9",".",10 ,12,x_axis+890 ,y_axis+222,Black,White);//MM30 H4

//Create_Button("button_FAKEMM50","MM50",60 ,17,x_axis+630 ,n_axis+60,Black,White); //BOTAO FAKE
//MM50
Create_Button("button_trigger_Moving_Average10",".",10 ,12,x_axis+900 ,y_axis+222,Black,White);//MM50 30
Create_Button("button_trigger_Moving_Average11",".",10 ,12,x_axis+910 ,y_axis+222,Black,White);//MM50 H1
Create_Button("button_trigger_Moving_Average12",".",10 ,12,x_axis+920 ,y_axis+222,Black,White);//MM50 H4

//Create_Button("button_FAKEMM100","MM100",60 ,17,m_axis+690 ,n_axis+60,Black,White); //BOTAO FAKE
//MM100
Create_Button("button_trigger_Moving_Average13",".",10 ,12,x_axis+930 ,y_axis+222,Black,White);//MM100 30
Create_Button("button_trigger_Moving_Average14",".",10 ,12,x_axis+940 ,y_axis+222,Black,White);//MM100 H1
Create_Button("button_trigger_Moving_Average15",".",10 ,12,x_axis+950 ,y_axis+222,Black,White);//MM100 H4

Create_Button("button_trigger_Candle_DirectionFAKE","Candle",30 ,12,x_axis+960 ,y_axis+210,Black,White); //BOTAO FAKE
Create_Button("button_trigger_Candle_Direction",".",30 ,12,x_axis+960 ,y_axis+222,Black,White);
/*Create_Button("button_1","CCI",41 ,12,x_axis+989 ,y_axis+210,Black,White);//CCI FAKE
Create_Button("button_2","RSI",41 ,12,x_axis+1030 ,y_axis+210,Black,White);//RSI FAKE
Create_Button("button_3","MACD",41 ,12,x_axis+1071 ,y_axis+210,Black,White);//MACD FAKE
Create_Button("button_UseCCI1",".",14 ,12,x_axis+989 ,y_axis+222,Black,White);//CCI M30 
Create_Button("button_UseCCI2",".",14 ,12,x_axis+1002 ,y_axis+222,Black,White);//CCI H1
Create_Button("button_UseCCI3",".",14 ,12,x_axis+1016 ,y_axis+222,Black,White);//CCI H4
Create_Button("button_UseRSI1",".",14 ,12,x_axis+1030 ,y_axis+222,Black,White);//RSI M30
Create_Button("button_UseRSI2",".",14 ,12,x_axis+1044 ,y_axis+222,Black,White);//RSI H1
Create_Button("button_UseRSI3",".",14 ,12,x_axis+1058 ,y_axis+222,Black,White);//RSI H4
Create_Button("button_trigger_MACD1",".",14 ,12,x_axis+1072 ,y_axis+222,Black,White);//MACD M30
Create_Button("button_trigger_MACD2",".",14 ,12,x_axis+1086 ,y_axis+222,Black,White);//MACD H1
Create_Button("button_trigger_MACD3",".",13 ,12,x_axis+1099 ,y_axis+222,Black,White);//MACD H4
*/Create_Button("button_trigger_use_Strength","USD",31 ,12,x_axis+1111 ,y_axis+222,Black,White);//USD
//SESSOES
Create_Button("button_trigger_use_TRADING","HFT ILLUSION",95 ,12,x_axis+305 ,y_axis+449,Black,White);//TRADING/CLOSE
Create_Button("button_autotrade","Manual",95 ,12,x_axis+305 ,y_axis+462,Black,clrGreen);//AUTOTRADE/MANUAL
Create_Button("button_UseSession1","AUD",55 ,12,x_axis+345 ,y_axis+355,Black,White);//SESSAO LONDRES
Create_Button("button_UseSession2","NZD",55 ,12,x_axis+345 ,y_axis+378,Black,White);//SESSAO TOKIO
Create_Button("button_UseSession3","JPY",55 ,12,x_axis+345 ,y_axis+400,Black,White);//SESSAO NOVA YORK
Create_Button("button_UseSession4","CHF",55 ,12,x_axis+345 ,y_axis+475,Black,White);//SESSAO LONDRES
Create_Button("button_UseSession5","EUR/GBP",55 ,12,x_axis+345 ,y_axis+497,Black,White);//SESSAO TOKIO
Create_Button("button_UseSession6","USD/CAD",55 ,12,x_axis+345 ,y_axis+520,Black,White);//SESSAO NOVA YORK

Create_Button(button_close_basket_All,"CLOSE ALL",90 ,12,x_axis+215 ,y_axis+413,Black,clrWhite);//
Create_Button(button_close_basket_Prof,"CLOSE PROFIT",90 ,12,x_axis+215 ,y_axis+426,Black,clrLime);//
Create_Button(button_close_basket_Loss,"CLOSE LOSS",90 ,12,x_axis+215 ,y_axis+449,Black,clrRed);//
Create_Button(button_reset_ea,"RESET EA",90 ,12,x_axis+215 ,y_axis+462,Black,clrYellow);//

  newday = 0;
  newm1=0;

/*  HP  */
  localday = 99;
  s1active = false;
  s2active = false;
  s3active = false;
  s4active = false;
  s5active = false;
  s6active = false;
  trailstarted = false;

  if (MaxTotalTrades == 0)
  maxtotaltrades = ArraySize(DefaultPairs) * MaxTrades;
  else
  maxtotaltrades = MaxTotalTrades;
                
/*  HP  */

  EventSetTimer(1);

  return(INIT_SUCCEEDED);
  }
  
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
  EventKillTimer();
  ObjectsDeleteAll();
  
  }

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
  DoWork();
//CalculateDailyDrawDown();
//DrawRiskInfo();
//DrawAccountInfo();
//DrawCurrentTrades();
//DrawTodayRange1();
//setCurrency();
//DeleteAllObject (); 
  Trades();

  TradeManager();

  get_list_status(list);//--- 
  
  PlotTrades();
  
  PlotSpreadPips();
  
  GetSignals();
  GetSignals1();  
            
  displayMeter();
  displayMeter1();  
  GetCommodity();
  GetCommodity1();
  GetCommodity2();
  GetCommodity3();
   
  if (newday != iTime("EURUSD"+postfix,PERIOD_D1,0))
  {
  GetAdrValues();
  PlotAdrValues();
  newday = iTime("EURUSD"+postfix,PERIOD_D1,0);
  }
  
  if (DashUpdate == 0 || (DashUpdate == 1 && newm1 != iTime("EURUSD"+postfix,PERIOD_M1,0)) || (DashUpdate == 5 && newm1 != iTime("EURUSD"+postfix,PERIOD_M5,0)))
  {
  
  for(int i=0; i<ArraySize(list); i++)//---
  
//  {//--- 
  //for(int i=0;i<ArraySize(TradePairs);i++) 
  for(int a=0;a<1;a++)
  {
  SetColors(i);
     
  ChngBoxCol((signals[i].Signalperc   * 100), i);      
  ChngBoxCol1((signals[i].Signalperc1 * 100), i);          
  ChngBoxCol2((signals[i].Signalperc2 * 100), i);
  ChngBoxCol3((signals[i].Signalperc3 * 100), i);
  ChngBoxCol4((signals[i].Signalperc4 * 100), i);          
  
  SetText("Percent"+IntegerToString(i),DoubleToStr(signals[i].Signalperc,2)+"%" ,x_axis+662,(i*15)+y_axis+234,clrBlack,7);
  SetText("Percnt2"+IntegerToString(i),DoubleToStr(signals[i].Signalperc1,2)+"%" ,x_axis+692,(i*15)+y_axis+234,clrBlack,7);
  SetText("Percent3"+IntegerToString(i),DoubleToStr(signals[i].Signalperc2,2)+"%" ,x_axis+722,(i*15)+y_axis+234,clrBlack,7);
  SetText("Percent4"+IntegerToString(i),DoubleToStr(signals[i].Signalperc3,2)+"%" ,x_axis+752,(i*15)+y_axis+234,clrBlack,7);
  SetText("Percent5"+IntegerToString(i),DoubleToStr(signals[i].Signalperc4,2)+"%" ,x_axis+782,(i*15)+y_axis+234,clrBlack,7);   

  if(MathAbs(signals[i].Signalusd)>MathAbs(signals[i].prevSignalusd)){SetObjText("SD"+IntegerToString(i),CharToStr(216),x_axis+1165,(i*15)+y_axis+234,BullColor,8);}
  if(MathAbs(signals[i].Signalusd)<MathAbs(signals[i].prevSignalusd)){SetObjText("SD"+IntegerToString(i),CharToStr(215),x_axis+1165,(i*15)+y_axis+234,BearColor,8);}
  if(signals[i].Signalusd==signals[i].prevSignalusd){SetObjText("SD"+IntegerToString(i),"",x_axis+1140,(i*15)+y_axis+234,clrGray,8);}
  ObjectSetText("usdintsig"+IntegerToString(i),DoubleToStr(MathAbs( signals[i].Signalusd),0)+"%",7,NULL,Color9);
      
  SetText("Pr1"+IntegerToString(i),list[i].symbol1,x_axis+50,(i*15)+y_axis+234,Colorstr1(list[i].ratio1),8);
  //SetText("Spread22"+IntegerToString(i),DoubleToStr(list[i].spread1,1),x_axis+55,(i*16)+y_axis+200,Orange,8);
  //SetText("Pips22"+IntegerToString(i),DoubleToStr(MathAbs(list[i].pips1),0),x_axis+80,(i*16)+y_axis+200,ColorPips1(list[i].pips1),8);
  //SetText("fxs"+IntegerToString(i),DoubleToStr(MathAbs(list[i].ratio1),1)+"%",x_axis+110,(i*16)+y_axis+200,Colorstr1(list[i].ratio1),8);
  //SetText("RelStrgth22"+IntegerToString(i),DoubleToStr(list[i].calc1,0),x_axis+200,(i*16)+y_axis+200,Colorsync1(list[i].calc1),8); 
  //SetText("BSR"+IntegerToString(i),DoubleToStr(signals[i].strength5,1),x_axis+480,(i*16)+y_axis+200,ColorBSRat(signals[i].strength5),8);
  //SetText("BSR"+IntegerToString(i),DoubleToStr(signals[i].strength5,1),x_axis+320,(i*16)+y_axis+200,ColorBSRat(signals[i].strength5),8);
  //SetText("PrevGap"+IntegerToString(i),DoubleToStr(signals[i].strength8,1),x_axis+525,(i*16)+y_axis+200,clrYellowGreen,8);
  //SetText("gap"+signals[i].symbol, DoubleToStr(signals[i].strength_Gap,1),x_axis+550,(i*16)+y_axis+200,ColorGap(signals[i].strength_Gap),8);
//BOTAO LOTES
ObjectSetText("LotSize","Lot:           "+DoubleToString(lot,2));
//BOTAO LOTES
//BOTAO STOPS
ObjectSetText("Piptp","PipTP:       "+DoubleToString(Piptp,2));
ObjectSetText("Pipsl","PipSL:       "+DoubleToString(Pipsl,2));
//---
ObjectSetText("Adr1tp","AdrTP: % "+DoubleToString(Adr1tp,2));
ObjectSetText("Adr1sl","AdrSL: % "+DoubleToString(Adr1sl,2));
//BOTAO STOPS
//HI-LO / ASK-BID
  //SetText("high"+IntegerToString(i),DoubleToStr(signals[i].high1,signals[i].digit1),x_axis+990,(i*15)+y_axis+234,clrGray,7);
  //SetText("ask"+IntegerToString(i),DoubleToStr(signals[i].ask1,signals[i].digit1),x_axis+1025,(i*15)+y_axis+234,clrGray,7); 
  //SetText("bid"+IntegerToString(i),DoubleToStr(signals[i].bid1,signals[i].digit1),x_axis+1060,(i*15)+y_axis+234,clrGray,7); 
  //SetText("low"+IntegerToString(i),DoubleToStr(signals[i].low1,signals[i].digit1),x_axis+1095,(i*15)+y_axis+234,clrGray,7); 
  //SetText("pointrange"+IntegerToString(i),DoubleToStr(signals[i].range2,0),x_axis+1130,(i*15)+y_axis+234,clrGray,7); 
//HI-LO / ASK-BID
   

  if(pairinfo[i].PipsSig==UP){SetObjText("Sigpips"+IntegerToString(i),CharToStr(217),x_axis+490,(i*15)+y_axis+234,BullColor,8);
  }
  else if(pairinfo[i].PipsSig==DOWN){SetObjText("Sigpips"+IntegerToString(i),CharToStr(218),x_axis+490,(i*15)+y_axis+234,BearColor,8);
  }

  if(signals[i].SignalM01up==UP){SetObjText("MM12M15"+IntegerToString(i),CharToStr(200),x_axis+810,(i*15)+y_axis+234,BullColor,8);}//06 MM12 
  if(signals[i].SignalM01up==DOWN){SetObjText("MM12M15"+IntegerToString(i),CharToStr(202),x_axis+810,(i*15)+y_axis+234,BearColor,8);}//06 MM12 
  if(signals[i].SignalM02dn==UP){SetObjText("MM12M30"+IntegerToString(i),CharToStr(200),x_axis+810,(i*15)+y_axis+234,BullColor,8);}//06 MM12 
  if(signals[i].SignalM02dn==DOWN){SetObjText("MM12M30"+IntegerToString(i),CharToStr(202),x_axis+810,(i*15)+y_axis+234,BearColor,8);}//06 MM12
  /*if(list[i].calc1==UP){SetObjText("MM12M15"+IntegerToString(i),DoubleToStr(list[i].calc1,0),x_axis+740,(i*15)+y_axis+229,Colorsync1(list[i].calc1),8);}//06 MM12 
  if(list[i].calc1==DOWN){SetObjText("MM12M15"+IntegerToString(i),DoubleToStr(list[i].calc1,0),x_axis+740,(i*15)+y_axis+229,Colorsync1(list[i].calc1),8);}//06 MM12 
  if(list[i].calc1==UP){SetObjText("MM12M30"+IntegerToString(i),DoubleToStr(list[i].calc1,0),x_axis+740,(i*15)+y_axis+229,Colorsync1(list[i].calc1),8);}//06 MM12 
  if(list[i].calc1==DOWN){SetObjText("MM12M30"+IntegerToString(i),DoubleToStr(list[i].calc1,0),x_axis+740,(i*15)+y_axis+229,Colorsync1(list[i].calc1),8);}//06 MM12*/ 
  if(signals[i].SignalM03up==UP){SetObjText("MM12H1"+IntegerToString(i),CharToStr(200),x_axis+820,(i*15)+y_axis+234,BullColor,8);}//06 MM12 
  if(signals[i].SignalM03up==DOWN){SetObjText("MM12H1"+IntegerToString(i),CharToStr(202),x_axis+820,(i*15)+y_axis+234,BearColor,8);}//06 MM12 
  if(signals[i].SignalM04dn==UP){SetObjText("MM12H4"+IntegerToString(i),CharToStr(200),x_axis+820,(i*15)+y_axis+234,BullColor,8);}//06 MM12 
  if(signals[i].SignalM04dn==DOWN){SetObjText("MM12H4"+IntegerToString(i),CharToStr(202),x_axis+820,(i*15)+y_axis+234,BearColor,8);}//06 MM12 
  if(signals[i].SignalM05up==UP){SetObjText("MM12D1"+IntegerToString(i),CharToStr(236),x_axis+830,(i*15)+y_axis+234,BullColor,8);}//06 MM12 
  if(signals[i].SignalM05up==DOWN){SetObjText("MM12D1"+IntegerToString(i),CharToStr(238),x_axis+830,(i*15)+y_axis+234,BearColor,8);}//06 MM12 
  if(signals[i].SignalM06dn==UP){SetObjText("MM12D1"+IntegerToString(i),CharToStr(236),x_axis+830,(i*15)+y_axis+234,BullColor,8);}//06 MM12 
  if(signals[i].SignalM06dn==DOWN){SetObjText("MM12D1"+IntegerToString(i),CharToStr(238),x_axis+830,(i*15)+y_axis+234,BearColor,8);}//06 MM12

  if(signals[i].SignalM07up==UP){SetObjText("MM21M15"+IntegerToString(i),CharToStr(200),x_axis+840,(i*15)+y_axis+234,BullColor,8);}//07 MM21 
  if(signals[i].SignalM07up==DOWN){SetObjText("MM21M15"+IntegerToString(i),CharToStr(202),x_axis+840,(i*15)+y_axis+234,BearColor,8);}//07 MM21 
  if(signals[i].SignalM08dn==UP){SetObjText("MM21M30"+IntegerToString(i),CharToStr(200),x_axis+840,(i*15)+y_axis+234,BullColor,8);}//07 MM21 
  if(signals[i].SignalM08dn==DOWN){SetObjText("MM21M30"+IntegerToString(i),CharToStr(202),x_axis+840,(i*15)+y_axis+234,BearColor,8);}//07 MM21 
  if(signals[i].SignalM09up==UP){SetObjText("MM21H1"+IntegerToString(i),CharToStr(200),x_axis+850,(i*15)+y_axis+234,BullColor,8);}//07 MM21  
  if(signals[i].SignalM09up==DOWN){SetObjText("MM21H1"+IntegerToString(i),CharToStr(202),x_axis+850,(i*15)+y_axis+234,BearColor,8);}//07 MM21 
  if(signals[i].SignalM10dn==UP){SetObjText("MM21H4"+IntegerToString(i),CharToStr(200),x_axis+850,(i*15)+y_axis+234,BullColor,8);}//07 MM21 
  if(signals[i].SignalM10dn==DOWN){SetObjText("MM21H4"+IntegerToString(i),CharToStr(202),x_axis+850,(i*15)+y_axis+234,BearColor,8);}//07 MM21 
  if(signals[i].SignalM11up==UP){SetObjText("MM21D1"+IntegerToString(i),CharToStr(236),x_axis+860,(i*15)+y_axis+234,BullColor,8);}//07 MM21 
  if(signals[i].SignalM11up==DOWN){SetObjText("MM21D1"+IntegerToString(i),CharToStr(238),x_axis+860,(i*15)+y_axis+234,BearColor,8);}//07 MM21  
  if(signals[i].SignalM12dn==UP){SetObjText("MM21D1"+IntegerToString(i),CharToStr(236),x_axis+860,(i*15)+y_axis+234,BullColor,8);}//07 MM21 
  if(signals[i].SignalM12dn==DOWN){SetObjText("MM21D1"+IntegerToString(i),CharToStr(238),x_axis+860,(i*15)+y_axis+234,BearColor,8);}//07 MM21  
  
  if(signals[i].SignalM13up==UP){SetObjText("MM30M15"+IntegerToString(i),CharToStr(200),x_axis+870,(i*15)+y_axis+234,BullColor,8);}//03 MM30 
  if(signals[i].SignalM13up==DOWN){SetObjText("MM30M15"+IntegerToString(i),CharToStr(202),x_axis+870,(i*15)+y_axis+234,BearColor,8);}//03 MM30 
  if(signals[i].SignalM14dn==UP){SetObjText("MM30M30"+IntegerToString(i),CharToStr(200),x_axis+870,(i*15)+y_axis+234,BullColor,8);}//03 MM30 
  if(signals[i].SignalM14dn==DOWN){SetObjText("MM30M30"+IntegerToString(i),CharToStr(202),x_axis+870,(i*15)+y_axis+234,BearColor,8);}//03 MM30 
  if(signals[i].SignalM15up==UP){SetObjText("MM30H1"+IntegerToString(i),CharToStr(200),x_axis+880,(i*15)+y_axis+234,BullColor,8);}//03 MM30 
  if(signals[i].SignalM15up==DOWN){SetObjText("MM30H1"+IntegerToString(i),CharToStr(202),x_axis+880,(i*15)+y_axis+234,BearColor,8);}//03 MM30 
  if(signals[i].SignalM16dn==UP){SetObjText("MM30H4"+IntegerToString(i),CharToStr(200),x_axis+880,(i*15)+y_axis+234,BullColor,8);}//03 MM30 
  if(signals[i].SignalM16dn==DOWN){SetObjText("MM30H4"+IntegerToString(i),CharToStr(202),x_axis+880,(i*15)+y_axis+234,BearColor,8);}//03 MM30 
  if(signals[i].SignalM17up==UP){SetObjText("MM30D1"+IntegerToString(i),CharToStr(236),x_axis+890,(i*15)+y_axis+234,BullColor,8);}//03 MM30 
  if(signals[i].SignalM17up==DOWN){SetObjText("MM30D1"+IntegerToString(i),CharToStr(238),x_axis+890,(i*15)+y_axis+234,BearColor,8);}//03 MM30  
  if(signals[i].SignalM18dn==UP){SetObjText("MM30D1"+IntegerToString(i),CharToStr(236),x_axis+890,(i*15)+y_axis+234,BullColor,8);}//03 MM30 
  if(signals[i].SignalM18dn==DOWN){SetObjText("MM30D1"+IntegerToString(i),CharToStr(238),x_axis+890,(i*15)+y_axis+234,BearColor,8);}//03 MM30  
  
  if(signals[i].SignalM19up==UP){SetObjText("MM50M15"+IntegerToString(i),CharToStr(200),x_axis+900,(i*15)+y_axis+234,BullColor,8);}//04 MM50 
  if(signals[i].SignalM19up==DOWN){SetObjText("MM50M15"+IntegerToString(i),CharToStr(202),x_axis+900,(i*15)+y_axis+234,BearColor,8);}//04 MM50 
  if(signals[i].SignalM20dn==UP){SetObjText("MM50M30"+IntegerToString(i),CharToStr(200),x_axis+900,(i*15)+y_axis+234,BullColor,8);}//04 MM50 
  if(signals[i].SignalM20dn==DOWN){SetObjText("MM50M30"+IntegerToString(i),CharToStr(202),x_axis+900,(i*15)+y_axis+234,BearColor,8);}//04 MM50 
  if(signals[i].SignalM21up==UP){SetObjText("MM50H1"+IntegerToString(i),CharToStr(200),x_axis+910,(i*15)+y_axis+234,BullColor,8);}//04 MM50 
  if(signals[i].SignalM21up==DOWN){SetObjText("MM50H1"+IntegerToString(i),CharToStr(202),x_axis+910,(i*15)+y_axis+234,BearColor,8);}//04 MM50  
  if(signals[i].SignalM22dn==UP){SetObjText("MM50H4"+IntegerToString(i),CharToStr(200),x_axis+910,(i*15)+y_axis+234,BullColor,8);}//04 MM50 
  if(signals[i].SignalM22dn==DOWN){SetObjText("MM50H4"+IntegerToString(i),CharToStr(202),x_axis+910,(i*15)+y_axis+234,BearColor,8);}//04 MM50  
  if(signals[i].SignalM23up==UP){SetObjText("MM50D1"+IntegerToString(i),CharToStr(236),x_axis+920,(i*15)+y_axis+234,BullColor,8);}//04 MM50 
  if(signals[i].SignalM23up==DOWN){SetObjText("MM50D1"+IntegerToString(i),CharToStr(238),x_axis+920,(i*15)+y_axis+234,BearColor,8);}//04 MM50  
  if(signals[i].SignalM24dn==UP){SetObjText("MM50D1"+IntegerToString(i),CharToStr(236),x_axis+920,(i*15)+y_axis+234,BullColor,8);}//04 MM50 
  if(signals[i].SignalM24dn==DOWN){SetObjText("MM50D1"+IntegerToString(i),CharToStr(238),x_axis+920,(i*15)+y_axis+234,BearColor,8);}//04 MM50
  
  if(signals[i].SignalM25up==UP){SetObjText("MM100M15"+IntegerToString(i),CharToStr(200),x_axis+930,(i*15)+y_axis+234,BullColor,8);}//05 MM100 
  if(signals[i].SignalM25up==DOWN){SetObjText("MM100M15"+IntegerToString(i),CharToStr(202),x_axis+930,(i*15)+y_axis+234,BearColor,8);}//05 MM100 
  if(signals[i].SignalM26dn==UP){SetObjText("MM100M30"+IntegerToString(i),CharToStr(200),x_axis+930,(i*15)+y_axis+234,BullColor,8);}//05 MM100 
  if(signals[i].SignalM26dn==DOWN){SetObjText("MM100M30"+IntegerToString(i),CharToStr(202),x_axis+930,(i*15)+y_axis+234,BearColor,8);}//05 MM100 
  if(signals[i].SignalM27up==UP){SetObjText("MM100H1"+IntegerToString(i),CharToStr(200),x_axis+940,(i*15)+y_axis+234,BullColor,8);}//05 MM100 
  if(signals[i].SignalM27up==DOWN){SetObjText("MM100H1"+IntegerToString(i),CharToStr(202),x_axis+940,(i*15)+y_axis+234,BearColor,8);}//05 MM100  
  if(signals[i].SignalM28dn==UP){SetObjText("MM100H4"+IntegerToString(i),CharToStr(200),x_axis+940,(i*15)+y_axis+234,BullColor,8);}//05 MM100 
  if(signals[i].SignalM28dn==DOWN){SetObjText("MM100H4"+IntegerToString(i),CharToStr(202),x_axis+940,(i*15)+y_axis+234,BearColor,8);}//05 MM100   
  if(signals[i].SignalM29up==UP){SetObjText("MM100D1"+IntegerToString(i),CharToStr(236),x_axis+950,(i*15)+y_axis+234,BullColor,8);}//05 MM100 
  if(signals[i].SignalM29up==DOWN){SetObjText("MM100D1"+IntegerToString(i),CharToStr(238),x_axis+950,(i*15)+y_axis+234,BearColor,8);}//05 MM100  
  if(signals[i].SignalM30dn==UP){SetObjText("MM100D1"+IntegerToString(i),CharToStr(236),x_axis+950,(i*15)+y_axis+234,BullColor,8);}//05 MM100 
  if(signals[i].SignalM30dn==DOWN){SetObjText("MM100D1"+IntegerToString(i),CharToStr(238),x_axis+950,(i*15)+y_axis+234,BearColor,8);}//05 MM100
  
  //CANDLE DIRECTION
  if(signals[i].SignalCDm1==UP){SetObjText("CDM1"+IntegerToString(i),CharToStr(127),x_axis+960,(i*15)+y_axis+234,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm1==DOWN){SetObjText("CDM1"+IntegerToString(i),CharToStr(127),x_axis+960,(i*15)+y_axis+234,BearColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm5==UP){SetObjText("CDM5"+IntegerToString(i),CharToStr(127),x_axis+965,(i*15)+y_axis+234,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm5==DOWN){SetObjText("CDM5"+IntegerToString(i),CharToStr(127),x_axis+965,(i*15)+y_axis+234,BearColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm15==UP){SetObjText("CDM15"+IntegerToString(i),CharToStr(127),x_axis+970,(i*15)+y_axis+234,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm15==DOWN){SetObjText("CDM15"+IntegerToString(i),CharToStr(127),x_axis+970,(i*15)+y_axis+234,BearColor,8);}//08 CANDLE DIRECTION      
  if(signals[i].SignalCDm30==UP){SetObjText("CDM30"+IntegerToString(i),CharToStr(127),x_axis+975,(i*15)+y_axis+234,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm30==DOWN){SetObjText("CDM30"+IntegerToString(i),CharToStr(127),x_axis+975,(i*15)+y_axis+234,BearColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDh1==UP){SetObjText("CDH1"+IntegerToString(i),CharToStr(127),x_axis+980,(i*15)+y_axis+234,BullColor,8);}//09 CANDLE DIRECTION
  if(signals[i].SignalCDh1==DOWN){SetObjText("CDH1"+IntegerToString(i),CharToStr(127),x_axis+980,(i*15)+y_axis+234,BearColor,8);}//09 CANDLE DIRECTION
  if(signals[i].SignalCDh4==UP){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+985,(i*15)+y_axis+234,BullColor,8);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDh4==DOWN){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+985,(i*15)+y_axis+234,BearColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDd1==UP){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+810,(i*15)+y_axis+234,BullColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDd1==DOWN){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+810,(i*15)+y_axis+234,BearColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDw1==UP){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+810,(i*15)+y_axis+234,BullColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDw1==DOWN){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+810,(i*15)+y_axis+234,BearColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDmn==UP){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+810,(i*15)+y_axis+234,BullColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDmn==DOWN){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+810,(i*15)+y_axis+234,BearColor,8);}//10 CANDLE DIRECTION
  //CCI-RSI-MACD
/*  if(signals[i].Signalcciup1==UP){SetObjText("CCIup1"+IntegerToString(i),CharToStr(241),x_axis+989,(i*15)+y_axis+234,BullColor,7);}//02 CCI M30
  if(signals[i].Signalccidn1==DOWN){SetObjText("CCIdn1"+IntegerToString(i),CharToStr(242),x_axis+995,(i*15)+y_axis+234,BearColor,7);}//02 CCI M30
  if(signals[i].Signalcciup2==UP){SetObjText("CCIup2"+IntegerToString(i),CharToStr(241),x_axis+1002,(i*15)+y_axis+234,BullColor,7);}//02 CCI H1
  if(signals[i].Signalccidn2==DOWN){SetObjText("CCIdn2"+IntegerToString(i),CharToStr(242),x_axis+1008,(i*15)+y_axis+234,BearColor,7);}//02 CCI H1
  if(signals[i].Signalcciup3==UP){SetObjText("CCIup3"+IntegerToString(i),CharToStr(241),x_axis+1016,(i*15)+y_axis+234,BullColor,7);}//02 CCI H4
  if(signals[i].Signalccidn3==DOWN){SetObjText("CCIdn3"+IntegerToString(i),CharToStr(242),x_axis+1022,(i*15)+y_axis+234,BearColor,7);}//02 CCI H4

  if(signals[i].Signalrsiup1==UP){SetObjText("RSIup1"+IntegerToString(i),CharToStr(241),x_axis+1030,(i*15)+y_axis+234,BullColor,7);}//01 RSI  M30
  if(signals[i].Signalrsidn1==DOWN){SetObjText("RSIdn1"+IntegerToString(i),CharToStr(242),x_axis+1036,(i*15)+y_axis+234,BearColor,7);}//01 RSI  M30 
  if(signals[i].Signalrsiup2==UP){SetObjText("RSIup2"+IntegerToString(i),CharToStr(241),x_axis+1044,(i*15)+y_axis+234,BullColor,7);}//01 RSI  H1
  if(signals[i].Signalrsidn2==DOWN){SetObjText("RSIdn2"+IntegerToString(i),CharToStr(242),x_axis+1050,(i*15)+y_axis+234,BearColor,7);}//01 RSI  H1
  if(signals[i].Signalrsiup3==UP){SetObjText("RSIup3"+IntegerToString(i),CharToStr(241),x_axis+1058,(i*15)+y_axis+234,BullColor,7);}//01 RSI  H4
  if(signals[i].Signalrsidn3==DOWN){SetObjText("RSIdn3"+IntegerToString(i),CharToStr(241),x_axis+1064,(i*15)+y_axis+234,BearColor,7);}//01 RSI  H4
  
  if(signals[i].SignalMACDup01==UP){SetObjText("MACDup1"+IntegerToString(i),CharToStr(241),x_axis+1072,(i*15)+y_axis+234,BullColor,7);}//MACD M30
  if(signals[i].SignalMACDdn01==DOWN){SetObjText("MACDdn1"+IntegerToString(i),CharToStr(242),x_axis+1078,(i*15)+y_axis+234,BearColor,7);}//MACD M30
  if(signals[i].SignalMACDup02==UP){SetObjText("MACDup2"+IntegerToString(i),CharToStr(241),x_axis+1086,(i*15)+y_axis+234,BullColor,7);}//MACD H1
  if(signals[i].SignalMACDdn02==DOWN){SetObjText("MACDdn2"+IntegerToString(i),CharToStr(242),x_axis+1092,(i*15)+y_axis+234,BearColor,7);}//MACD H1  
  if(signals[i].SignalMACDup03==UP){SetObjText("MACDup3"+IntegerToString(i),CharToStr(241),x_axis+1099,(i*15)+y_axis+234,BullColor,7);}//MACD H4
  if(signals[i].SignalMACDdn03==DOWN){SetObjText("MACDdn3"+IntegerToString(i),CharToStr(242),x_axis+1105,(i*15)+y_axis+234,BearColor,7);}//MACD H4     
*/  SetText("fxs"+IntegerToString(i),DoubleToStr(MathAbs(list[i].ratio1),1)+"%",x_axis+125,(i*15)+y_axis+234,Colorstr1(list[i].ratio1),8);//---
  SetText("BidRat"+IntegerToString(i),DoubleToStr(signals[i].ratio,1)+"%",x_axis+525,(i*15)+y_axis+234,Colorstr(signals[i].ratio),8); 
    //SetText("Spread22"+IntegerToString(i),DoubleToStr(list[i].spread1,1),x_axis+55,(i*15)+y_axis+234,Orange,8);
  SetText("Pips22"+IntegerToString(i),DoubleToStr(MathAbs(list[i].pips1),0),x_axis+100,(i*15)+y_axis+234,ColorPips1(list[i].pips1),8);
  SetText("RelStrgth22"+IntegerToString(i),DoubleToStr(list[i].calc1,0),x_axis+195,(i*15)+y_axis+234,Colorsync1(list[i].calc1),8); 
  SetText("BSR"+IntegerToString(i),DoubleToStr(signals[i].strength5,1),x_axis+569,(i*15)+y_axis+234,ColorBSRat(signals[i].strength5),8);
  //SetText("BSR"+IntegerToString(i),DoubleToStr(signals[i].strength5,1),x_axis+320,(i*15)+y_axis+229,ColorBSRat(signals[i].strength5),8);
  SetText("RelStrgth"+IntegerToString(i),DoubleToStr(signals[i].calc,0),x_axis+590,(i*15)+y_axis+234,Colorsync(signals[i].calc),8);
  SetText("PrevGap"+IntegerToString(i),DoubleToStr(signals[i].strength8,1),x_axis+605,(i*15)+y_axis+234,clrYellowGreen,8);
  SetText("gap"+signals[i].symbol, DoubleToStr(signals[i].strength_Gap,1),x_axis+630,(i*15)+y_axis+234,ColorGap(signals[i].strength_Gap),8);
  
  if(list[i].ratio1>0){SetObjText("Sig22"+IntegerToString(i),CharToStr(217),x_axis+165,(i*15)+y_axis+234,BullColor,8);}//---
  else if(list[i].ratio1<0){SetObjText("Sig22"+IntegerToString(i),CharToStr(218),x_axis+165,(i*15)+y_axis+234,BearColor,8);}//---
   
  for(int b=0; b<=list[i].calc1-1; b++)//---
  {
  ObjectDelete("fx1"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list[i].ratio1>0){SetText("fx1"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+x_axis+165,(i*15)+y_axis+234,BullColor,8);}//---
  else if(list[i].ratio1<0){SetText("fx1"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+x_axis+165,(i*15)+y_axis+234,BearColor,8);}//---
  }//---
  
  if(signals[i].SigRatioPrev==UP){SetObjText("Sig"+IntegerToString(i),CharToStr(217),x_axis+555,(i*15)+y_axis+234,BullColor,8);
  }
  else if(signals[i].SigRatioPrev==DOWN){SetObjText("Sig"+IntegerToString(i),CharToStr(218),x_axis+555,(i*15)+y_axis+234,BearColor,8);
  }
  
  if(signals[i].SigGapPrev==UP){SetObjText("GapSig"+IntegerToString(i),CharToStr(217),x_axis+650,(i*15)+y_axis+234,BullColor,8);
  }
  else if(signals[i].SigGapPrev==DOWN){SetObjText("GapSig"+IntegerToString(i),CharToStr(218),x_axis+650,(i*15)+y_axis+234,BearColor,8);
  }
  else {SetObjText("GapSig"+IntegerToString(i),CharToStr(251),x_axis+650,(i*15)+y_axis+234,clrWhite,8);
  }
//---------------------------------------------------------------------------------------------------------------------------+                
  if (((pairinfo[i].PipsSig==UP && pairinfo[i].Pips > trade_MIN_pips) || trigger_use_Pips==false)
  &&(signals[i].Signalusd > trade_MIN_Strength || trigger_use_Strength==false)
  && ((signals[i].SigRatioPrev==UP && signals[i].ratio>=trigger_buy_bidratio) || trigger_use_bidratio==false)
  && (/*(signals[i].SigRatioPrev==UP &&*/ list[i].ratio1>=trigger_buy_bidratio1/*)*/ || trigger_use_bidratio1==false)
  && (signals[i].calc>=trigger_buy_relstrength || trigger_use_relstrength==false)
  && (list[i].calc1>=trigger_buy_relstrength1 || trigger_use_relstrength1==false)
  && (signals[i].strength5>=trigger_buy_buysellratio || trigger_use_buysellratio==false)
  && ((signals[i].SigGapPrev==UP && signals[i].strength_Gap>=trigger_gap_buy) || trigger_use_gap==false) 
  && (signals[i].Signalperc >trade_MIN_HeatMap1 || trigger_UseHeatMap1==false)
  && (signals[i].Signalperc1 >trade_MIN_HeatMap2 || trigger_UseHeatMap2==false)
  && (signals[i].Signalperc2 >trade_MIN_HeatMap3 || trigger_UseHeatMap3==false)
  && (signals[i].Signalperc3 >trade_MIN_HeatMap4 || trigger_UseHeatMap4==false)
  && (signals[i].Signalperc4 >trade_MIN_HeatMap5 || trigger_UseHeatMap5==false)
 
  && (signals[i].SignalM01up>0||trigger_Moving_Average1==false )
  /*&& (list[i].calc1>0||trigger_Moving_Average1==false )*/
  && (signals[i].SignalM03up>0||trigger_Moving_Average2==false )
  && (signals[i].SignalM05up>0||trigger_Moving_Average3==false )

  && (signals[i].SignalM07up>0||trigger_Moving_Average4==false )
  && (signals[i].SignalM09up>0||trigger_Moving_Average5==false )
  && (signals[i].SignalM11up>0||trigger_Moving_Average6==false )

  && (signals[i].SignalM13up>0||trigger_Moving_Average7==false )
  && (signals[i].SignalM15up>0||trigger_Moving_Average8==false )
  && (signals[i].SignalM17up>0||trigger_Moving_Average9==false )

  && (signals[i].SignalM19up>0||trigger_Moving_Average10==false )
  && (signals[i].SignalM21up>0||trigger_Moving_Average11==false )
  && (signals[i].SignalM23up>0||trigger_Moving_Average12==false )

  && (signals[i].SignalM25up>0||trigger_Moving_Average13==false )
  && (signals[i].SignalM27up>0||trigger_Moving_Average14==false )
  && (signals[i].SignalM29up>0||trigger_Moving_Average15==false )
  
  && (signals[i].Signaldirup>0||trigger_Candle_Direction==false)

  && (signals[i].Signalcciup1 >= UP || UseCCI1==false)
  && (signals[i].Signalcciup2 >= UP || UseCCI2==false)
  && (signals[i].Signalcciup3 >= UP || UseCCI3==false)
  && (signals[i].Signalrsiup1 >= UP || UseRSI1==false)
  && (signals[i].Signalrsiup2 >= UP || UseRSI2==false)
  && (signals[i].Signalrsiup3 >= UP || UseRSI3==false)
  && (signals[i].SignalMACDup01 >= UP || trigger_MACD1==false)
  && (signals[i].SignalMACDup02 >= UP || trigger_MACD2==false)
  && (signals[i].SignalMACDup03 >= UP || trigger_MACD3==false))      
  
  {
  labelcolor = clrLime;
  if ((bpos[i]+spos[i]) < MaxTrades && pairinfo[i].lastSignal != BUY && autotrade == true && (OnlyAddProfit == false || bprofit[i] >= 0.0) && pairinfo[i].Spread <= MaxSpread && inSession() == true && totaltrades <= maxtotaltrades)
  {
  pairinfo[i].lastSignal = BUY;

  while (IsTradeContextBusy()) Sleep(100);
  ticket=OrderSend(DefaultPairs[i],OP_BUY,lot,MarketInfo(DefaultPairs[i],MODE_ASK),100,0,0,comment,Magic_Number,0,Blue);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) 
  {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() - Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice() - ((adrvalues[i].adr1/100)*Adr1sl) * pairinfo[i].PairPip;
  else
  stoploss = 0.0;
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() + Piptp * pairinfo[i].PairPip;
  else
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() + ((adrvalues[i].adr1/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
  
  while (IsTradeContextBusy()) Sleep(100);
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(DefaultPairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(DefaultPairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  }
  else
  {
  if (((pairinfo[i].PipsSig==DOWN && pairinfo[i].Pips < -trade_MIN_pips) || trigger_use_Pips==false)
  &&(signals[i].Signalusd < -trade_MIN_Strength || trigger_use_Strength==false) 
  && ((signals[i].SigRatioPrev==DOWN && signals[i].ratio<=trigger_sell_bidratio) || trigger_use_bidratio==false)
  && (/*(signals[i].SigRatioPrev==DOWN &&*/ list[i].ratio1<=trigger_sell_bidratio1/*)*/ || trigger_use_bidratio1==false)
  && (signals[i].calc<=trigger_sell_relstrength || trigger_use_relstrength==false)
  && (list[i].calc1<=trigger_sell_relstrength1 || trigger_use_relstrength1==false)
  && (signals[i].strength5<=trigger_sell_buysellratio || trigger_use_buysellratio==false)
  && ((signals[i].SigGapPrev==DOWN && signals[i].strength_Gap<=trigger_gap_sell) || trigger_use_gap==false)         
  && (signals[i].Signalperc <-trade_MIN_HeatMap1 || trigger_UseHeatMap1==false)
  && (signals[i].Signalperc1 <-trade_MIN_HeatMap2 || trigger_UseHeatMap2==false)
  && (signals[i].Signalperc2 <-trade_MIN_HeatMap3 || trigger_UseHeatMap3==false)
  && (signals[i].Signalperc3 <-trade_MIN_HeatMap4 || trigger_UseHeatMap4==false)
  && (signals[i].Signalperc4 <-trade_MIN_HeatMap5 || trigger_UseHeatMap5==false)
  
  && (signals[i].SignalM02dn<0||trigger_Moving_Average1==false )
  /*&& (list[i].calc1<0||trigger_Moving_Average1==false )*/
  && (signals[i].SignalM04dn<0||trigger_Moving_Average2==false )
  && (signals[i].SignalM06dn<0||trigger_Moving_Average3==false )

  && (signals[i].SignalM08dn<0||trigger_Moving_Average4==false )
  && (signals[i].SignalM10dn<0||trigger_Moving_Average5==false )
  && (signals[i].SignalM12dn<0||trigger_Moving_Average6==false )

  && (signals[i].SignalM14dn<0||trigger_Moving_Average7==false )
  && (signals[i].SignalM16dn<0||trigger_Moving_Average8==false )
  && (signals[i].SignalM18dn<0||trigger_Moving_Average9==false )

  && (signals[i].SignalM20dn<0||trigger_Moving_Average10==false )
  && (signals[i].SignalM22dn<0||trigger_Moving_Average11==false )
  && (signals[i].SignalM24dn<0||trigger_Moving_Average12==false )

  && (signals[i].SignalM26dn<0||trigger_Moving_Average13==false )
  && (signals[i].SignalM28dn<0||trigger_Moving_Average14==false )
  && (signals[i].SignalM30dn<0||trigger_Moving_Average15==false )
  
  && (signals[i].Signaldirdn>0||trigger_Candle_Direction==false)

  && (signals[i].Signalccidn1 <= DOWN || UseCCI1==false)
  && (signals[i].Signalccidn2 <= DOWN || UseCCI2==false)
  && (signals[i].Signalccidn3 <= DOWN || UseCCI3==false)
  && (signals[i].Signalrsidn1 <= DOWN || UseRSI1==false)
  && (signals[i].Signalrsidn2 <= DOWN || UseRSI2==false)
  && (signals[i].Signalrsidn3 <= DOWN || UseRSI3==false)
  && (signals[i].SignalMACDdn01 <= DOWN || trigger_MACD1==false)
  && (signals[i].SignalMACDdn02 <= DOWN || trigger_MACD1==false)
  && (signals[i].SignalMACDdn03 <= DOWN || trigger_MACD2==false))        
  {
  labelcolor = clrRed;           
  if ((bpos[i]+spos[i]) < MaxTrades && pairinfo[i].lastSignal != SELL && autotrade == true && (OnlyAddProfit == false || sprofit[i] >= 0.0) && pairinfo[i].Spread <= MaxSpread && inSession() == true && totaltrades <= maxtotaltrades)
  {
  pairinfo[i].lastSignal = SELL;

  while (IsTradeContextBusy()) Sleep(100);
  ticket=OrderSend(DefaultPairs[i],OP_SELL,lot,MarketInfo(DefaultPairs[i],MODE_BID),100,0,0,comment,Magic_Number,0,Red);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) 
  {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() + Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice()+((adrvalues[i].adr1/100)*Adr1sl)  *pairinfo[i].PairPip;
  else
  stoploss = 0.0;

  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() - Piptp * pairinfo[i].PairPip;
  else 
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() - ((adrvalues[i].adr1/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
  
  while (IsTradeContextBusy()) Sleep(100);
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(DefaultPairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(DefaultPairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  } 
  else
  {
  labelcolor = BackGrnCol;
  pairinfo[i].lastSignal = NOTHING;
  }  
  }
  string HM0 = iCustom(NULL, 0, "HeatMapModokiV1",5, 10, "Arial", 585 , 250, 0 , 0,i);
  string HM1 = iCustom(NULL, 0, "HeatMapModokiV1",15, 10, "Arial", 620 , 250, 0 , 0,i);
  string HM2 = iCustom(NULL, 0, "HeatMapModokiV1",30, 10, "Arial", 655 , 250, 0 , 0,i);
  string HM3 = iCustom(NULL, 0, "HeatMapModokiV1",240, 10, "Arial", 690 , 250, 0 , 0,i);
  string HM4 = iCustom(NULL, 0, "HeatMapModokiV1",1440, 10, "Arial", 725 , 250, 0 , 0,i);
  
  ColorPanel("Spread"+IntegerToString(i),labelcolor,C'61,61,61');        
  ColorPanel("Pips"+IntegerToString(i),labelcolor,C'61,61,61');
  ColorPanel("Adr"+IntegerToString(i),labelcolor,C'61,61,61');         
  ColorPanel("TP",Black,White);
  ColorPanel("TP1",Black,White);
  ColorPanel("TP2",Black,White);
  ColorPanel("TP3",Black,White);
  ColorPanel("TP4",Black,White);
  ColorPanel("TP5",Black,White);
  ColorPanel("A1"+IntegerToString(i),C'30,30,30',C'61,61,61');
  ColorPanel("A2"+IntegerToString(i),labelcolor,C'61,61,61');          
  ColorPanel("A3"+IntegerToString(i),C'30,30,30',C'61,61,61');   
  ColorPanel("B11"+IntegerToString(i),labelcolor1,labelcolor2);
  ColorPanel("B21"+IntegerToString(i),labelcolor3,labelcolor2);
  ColorPanel("B31"+IntegerToString(i),labelcolor4,labelcolor2);
  ColorPanel("B41"+IntegerToString(i),labelcolor5,labelcolor2);
  ColorPanel("B51"+IntegerToString(i),labelcolor6,labelcolor2);
  ColorPanel("B61"+IntegerToString(i),labelcolor7,labelcolor2);
  ColorPanel("B71"+IntegerToString(i),labelcolor8,labelcolor2);
  ColorPanel("B81"+IntegerToString(i),labelcolor9,labelcolor2);
  ColorPanel("B91"+IntegerToString(i),labelcolor10,labelcolor2);
  ColorPanel("B101"+IntegerToString(i),labelcolor11,labelcolor2);
  ColorPanel("A222"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("B2222"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("A2223"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("B22223"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  //ColorPanel("Spread222"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  //ColorPanel("Spread222"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  //CANDLE DIRECTION
  //ColorPanel("m1"+IntegerToString(i),clrNONE,clrBlack);
  //ColorPanel("m5"+IntegerToString(i),clrBlack,White);
  //ColorPanel("m15"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("m30"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("h1"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("h4"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("d1"+IntegerToString(i),clrBlack,C'0,0,0');
  //ColorPanel("w1"+IntegerToString(i),clrBlack,C'0,0,0');
  //ColorPanel("mn1"+IntegerToString(i),clrBlack,C'0,0,0');
  //CANDLE DIRECTION         
  //ColorPanel("A2"+IntegerToString(i),labelcolor,C'61,61,61');          
  ColorPanel("DIR"+IntegerToString(i),labelcolor,C'0,0,0');         
  }
  if (DashUpdate == 1)
  newm1 = iTime("EURUSD"+postfix,PERIOD_M1,0);
  else if (DashUpdate == 5)
  newm1 = iTime("EURUSD"+postfix,PERIOD_M5,0);
  }
  WindowRedraw();    
  }
//+------------------------------------------------------------------+
void SetText(string name,string text,int x,int y,color colour,int fontsize=12,double fontsize1=8,string fontface="Arial")
  {
  if (ObjectFind(0,name)<0)
  ObjectCreate(0,name,OBJ_LABEL,0,0,0);
  
  ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
  ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
  ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
  ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
  ObjectSetString(0,name,OBJPROP_TEXT,text);
  ObjectSetString(0,name,OBJPROP_FONT,fontface);
  }
//+------------------------------------------------------------------+
void SetObjText(string name,string CharToStr,int x,int y,color colour,int fontsize=12,double fontsize1=8,string fontface="Wingdings")
  {
  if(ObjectFind(0,name)<0)
  ObjectCreate(0,name,OBJ_LABEL,0,0,0);
  
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
  ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
  ObjectSetInteger(0,name,OBJPROP_BACK,false);
  ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
  ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
  ObjectSetString(0,name,OBJPROP_TEXT,CharToStr);
  ObjectSetString(0,name,OBJPROP_FONT,"Wingdings");
  }  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetPanel(string name,int sub_window,int x,int y,int width,int height,color bg_color,color border_clr,int border_width)
  {
  if(ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
  {
  ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
  ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
  ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
  ObjectSetInteger(0,name,OBJPROP_YSIZE,height);
  ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
  ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
  ObjectSetInteger(0,name,OBJPROP_WIDTH,border_width);
  ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
  ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
  ObjectSetInteger(0,name,OBJPROP_BACK,true);
  ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
  ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
  ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
  }
  ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
void ColorPanel(string name,color bg_color,color border_clr,color border_clr1=clrNONE,color fg_color=NULL)
  {
  ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
  ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
//+------------------------------------------------------------------+
void Create_Button(string but_name,string label,int xsize,int ysize,int xdist,int ydist,int bcolor,int fcolor,color bgcolor=clrBlack,
                   color border_color=clrNONE,
                   color fgcolor=clrWhite,
                   string fontface="Arial",
                   double fontsize=8,
                   double fontsize1=8,
                   bool selectable=false,
                   bool selected=false,
                   bool state=false)
  {
  if(ObjectFind(0,but_name)<0)
  {
  if(!ObjectCreate(0,but_name,OBJ_BUTTON,0,0,0))
  {
  Print(__FUNCTION__,
  ": failed to create the button! Error code = ",GetLastError());
  return;
  }
  ObjectSetString(0,but_name,OBJPROP_TEXT,label);
  ObjectSetInteger(0,but_name,OBJPROP_XSIZE,xsize);
  ObjectSetInteger(0,but_name,OBJPROP_YSIZE,ysize);
  ObjectSetInteger(0,but_name,OBJPROP_CORNER,CORNER_LEFT_UPPER);     
  ObjectSetInteger(0,but_name,OBJPROP_XDISTANCE,xdist);      
  ObjectSetInteger(0,but_name,OBJPROP_YDISTANCE,ydist);         
  ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bcolor);
  ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bgcolor);
  ObjectSetInteger(0,but_name,OBJPROP_BORDER_COLOR,border_color);
  ObjectSetInteger(0,but_name,OBJPROP_COLOR,fgcolor);
  ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,fontsize);
  ObjectSetInteger(0,but_name,OBJPROP_COLOR,fcolor);
  ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,but_name,OBJPROP_HIDDEN,true);
  //ObjectSetInteger(0,but_name,OBJPROP_BORDER_COLOR,ChartGetInteger(0,CHART_COLOR_FOREGROUND));
  ObjectSetInteger(0,but_name,OBJPROP_BORDER_TYPE,BORDER_RAISED);
  ObjectSetString(0,but_name,OBJPROP_FONT,fontface);

  //--- enable (true) or disable (false) the mode of moving the button by mouse
  ObjectSetInteger(0,but_name,OBJPROP_SELECTABLE,selectable);
  ObjectSetInteger(0,but_name,OBJPROP_SELECTED,selected);
  //--- set button state
  ObjectSetInteger(0,but_name,OBJPROP_STATE,state);
  //--- hide (true) or display (false) graphical object name in the object list

  ChartRedraw();      
  }
  }
void OnChartEvent(const int id,  const long &lparam, const double &dparam,  const string &sparam)
  {
  if(id==CHARTEVENT_OBJECT_CLICK)  
//----------------------------------------------------------------
  {
  }
if(sparam=="button_autotrade" && autotrade ==false)
  {
  autotrade =true;
  ObjectSetInteger(0,"button_autotrade",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_autotrade",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_autotrade",OBJPROP_TEXT,"Autotrade");
  Sleep(100);ObjectSetInteger(0,"button_autotrade",OBJPROP_STATE,false);
  }
  else if(sparam=="button_autotrade" && autotrade ==true)
  {
  autotrade=false;
  ObjectSetInteger(0,"button_autotrade",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_autotrade",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_autotrade",OBJPROP_TEXT,"Manual");
  Sleep(100);ObjectSetInteger(0,"button_autotrade",OBJPROP_STATE,false); 
  }
//BOTAO ACCOUNT MANAGER
  if(sparam=="button_trigger_use_ShowProfitInfo" && ShowProfitInfo ==false)
  {
  ShowProfitInfo =true;
  ObjectSetInteger(0,"button_trigger_use_ShowProfitInfo",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowProfitInfo",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowProfitInfo",OBJPROP_TEXT,"Account");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowProfitInfo",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowProfitInfo"&& ShowProfitInfo ==true)
  {
  ShowProfitInfo =false;
  ObjectSetInteger(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_TEXT,"Account");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_STATE,false); 
  }
  //---
  if(sparam=="button_trigger_use_ShowTodayRanges" && ShowTodayRanges ==false)
  {
  ShowTodayRanges =true;
  ObjectSetInteger(0,"button_trigger_use_ShowTodayRanges",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowTodayRanges",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowTodayRanges",OBJPROP_TEXT,"Ranges");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowTodayRanges",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowTodayRanges"&& ShowTodayRanges ==true)
  {
  ShowTodayRanges =false;
  ObjectSetInteger(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_TEXT,"Ranges");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_STATE,false); 
  }
  //---
  if(sparam=="button_trigger_use_ShowRiskInfo" && ShowRiskInfo ==false)
  {
  ShowRiskInfo =true;
  ObjectSetInteger(0,"button_trigger_use_ShowRiskInfo",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowRiskInfo",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowRiskInfo",OBJPROP_TEXT,"Risk");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowRiskInfo",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowRiskInfo"&& ShowRiskInfo ==true)
  {
  ShowRiskInfo =false;
  ObjectSetInteger(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_TEXT,"Risk");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_STATE,false); 
  }
  //---
  if(sparam=="button_trigger_use_ShowAccountOrderInfo" && ShowAccountOrderInfo ==false)
  {
  ShowAccountOrderInfo =true;
  ObjectSetInteger(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_TEXT,"Order");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowAccountOrderInfo"&& ShowAccountOrderInfo ==true)
  {
  ShowAccountOrderInfo =false;
  ObjectSetInteger(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_TEXT,"Order");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_STATE,false); 
  }
  //BOTAO ACCOUNT MANAGER     
  //---BOTAO INDICADORES  
  if(sparam=="button_trigger_use_Pips" && trigger_use_Pips ==false)
  {
  trigger_use_Pips =true;
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_use_Pips",OBJPROP_TEXT,"Pips");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_Pips" && trigger_use_Pips ==true)
  {
  trigger_use_Pips=false;
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_Pips",OBJPROP_TEXT,"Pips");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_use_bidratio" && trigger_use_bidratio ==false)
  {
  trigger_use_bidratio =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_use_bidratio",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio" && trigger_use_bidratio ==true)
  {
  trigger_use_bidratio=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_use_bidratio1" && trigger_use_bidratio1 ==false)
  {
  trigger_use_bidratio1 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio1",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_use_bidratio1",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio1" && trigger_use_bidratio1 ==true)
  {
  trigger_use_bidratio1=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio1",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio1",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_use_relstrength" && trigger_use_relstrength ==false)
  {
  trigger_use_relstrength =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_use_relstrength",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength" && trigger_use_relstrength ==true)
  {
  trigger_use_relstrength=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_use_relstrength1" && trigger_use_relstrength1 ==false)
  {
  trigger_use_relstrength1 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength1",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_use_relstrength1",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength1" && trigger_use_relstrength1 ==true)
  {
  trigger_use_relstrength1=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength1",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength1",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_use_buysellratio" && trigger_use_buysellratio ==false)
  {
  trigger_use_buysellratio =true;
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_use_buysellratio",OBJPROP_TEXT,"BSRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_buysellratio" && trigger_use_buysellratio ==true)
  {
  trigger_use_buysellratio=false;
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_buysellratio",OBJPROP_TEXT,"BSRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_use_gap" && trigger_use_gap ==false)
  {
  trigger_use_gap =true;
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_use_gap",OBJPROP_TEXT,"Gap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_gap" && trigger_use_gap ==true)
  {
  trigger_use_gap=false;
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_gap",OBJPROP_TEXT,"Gap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_UseHeatMap1" && trigger_UseHeatMap1 ==false)
  {
  trigger_UseHeatMap1 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_UseHeatMap1",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap1" && trigger_UseHeatMap1 ==true)
  {
  trigger_UseHeatMap1=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap1",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_UseHeatMap2" && trigger_UseHeatMap2 ==false)
  {
  trigger_UseHeatMap2 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_UseHeatMap2",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap2" && trigger_UseHeatMap2 ==true)
  {
  trigger_UseHeatMap2=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap2",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_UseHeatMap3" && trigger_UseHeatMap3 ==false)
  {
  trigger_UseHeatMap3 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_UseHeatMap3",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap3" && trigger_UseHeatMap3 ==true)
  {
  trigger_UseHeatMap3=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap3",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_UseHeatMap4" && trigger_UseHeatMap4 ==false)
  {
  trigger_UseHeatMap4 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_UseHeatMap4",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap4" && trigger_UseHeatMap4 ==true)
  {
  trigger_UseHeatMap4=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap4",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_UseHeatMap5" && trigger_UseHeatMap5 ==false)
  {
  trigger_UseHeatMap5 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_UseHeatMap5",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap5" && trigger_UseHeatMap5 ==true)
  {
  trigger_UseHeatMap5=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap5",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_STATE,false);
  }
//---BOTAO INDICADORES  
  if(sparam=="button_trigger_Moving_Average1" && trigger_Moving_Average1 ==false)//MM12
  {
  trigger_Moving_Average1 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average1",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average1" && trigger_Moving_Average1 ==true)
  {
  trigger_Moving_Average1=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average1",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average2" && trigger_Moving_Average2 ==false)//MM12
  {
  trigger_Moving_Average2 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average2",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average2" && trigger_Moving_Average2 ==true)
  {
  trigger_Moving_Average2=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average2",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average3" && trigger_Moving_Average3 ==false)//MM12
  {
  trigger_Moving_Average3 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average3",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average3" && trigger_Moving_Average3 ==true)
  {
  trigger_Moving_Average3=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average3",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average4" && trigger_Moving_Average4 ==false)//MM21
  {
  trigger_Moving_Average4 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average4",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average4" && trigger_Moving_Average4 ==true)
  {
  trigger_Moving_Average4=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average4",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average5" && trigger_Moving_Average5 ==false)//MM21
  {
  trigger_Moving_Average5 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average5",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average5" && trigger_Moving_Average5 ==true)
  {
  trigger_Moving_Average5=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average5",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_STATE,false);
  }
//---
  if(sparam=="button_trigger_Moving_Average6" && trigger_Moving_Average6 ==false)//MM21
  {
  trigger_Moving_Average6 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average6",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average6" && trigger_Moving_Average6 ==true)
  {
  trigger_Moving_Average6=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average6",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average7" && trigger_Moving_Average7 ==false)//MM30
  {
  trigger_Moving_Average7 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average7",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average7" && trigger_Moving_Average7 ==true)
  {
  trigger_Moving_Average7=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average7",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average8" && trigger_Moving_Average8 ==false)//MM30
  {
  trigger_Moving_Average8 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average8",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average8" && trigger_Moving_Average8 ==true)
  {
  trigger_Moving_Average8=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average8",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average9" && trigger_Moving_Average9 ==false)//MM30
  {
  trigger_Moving_Average9 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average9",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average9" && trigger_Moving_Average9 ==true)
  {
  trigger_Moving_Average9=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average9",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average10" && trigger_Moving_Average10 ==false)//MM50
  {
  trigger_Moving_Average10 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average10",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average10" && trigger_Moving_Average10 ==true)
  {
  trigger_Moving_Average10=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average10",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_STATE,false);
  }      
//---
  if(sparam=="button_trigger_Moving_Average11" && trigger_Moving_Average11 ==false)//MM50
  {
  trigger_Moving_Average11 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average11",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average11" && trigger_Moving_Average11 ==true)
  {
  trigger_Moving_Average11=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average11",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average12" && trigger_Moving_Average12 ==false)//MM50
  {
  trigger_Moving_Average12 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average12",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average12" && trigger_Moving_Average12 ==true)
  {
  trigger_Moving_Average12=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average12",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average13" && trigger_Moving_Average13 ==false)//MM100
  {
  trigger_Moving_Average13 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average13",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average13" && trigger_Moving_Average13 ==true)
  {
  trigger_Moving_Average13=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average13",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average14" && trigger_Moving_Average14 ==false)//MM100
  {
  trigger_Moving_Average14 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average14",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average14" && trigger_Moving_Average14 ==true)
  {
  trigger_Moving_Average14=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average14",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Moving_Average15" && trigger_Moving_Average15 ==false)//MM100
  {
  trigger_Moving_Average15 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Moving_Average15",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average15" && trigger_Moving_Average15 ==true)
  {
  trigger_Moving_Average15=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average15",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_STATE,false);
  }
      
//MEDIA MOVEL TF POR PERIODO
  if(sparam=="button_UseCCI1" && UseCCI1 ==false)
  {
  UseCCI1 =true;
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_UseCCI1",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseCCI1" && UseCCI1 ==true)
  {
  UseCCI1=false;
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseCCI1",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI1",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_UseCCI2" && UseCCI2 ==false)
  {
  UseCCI2 =true;
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_UseCCI2",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseCCI2" && UseCCI2 ==true)
  {
  UseCCI2=false;
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseCCI2",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI2",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_UseCCI3" && UseCCI3 ==false)
  {
  UseCCI3 =true;
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_UseCCI3",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseCCI3" && UseCCI3 ==true)
  {
  UseCCI3=false;
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseCCI3",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI3",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_UseRSI1" && UseRSI1 ==false)
  {
  UseRSI1 =true;
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_UseRSI1",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseRSI1" && UseRSI1 ==true)
  {
  UseRSI1=false;
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseRSI1",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI1",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_UseRSI2" && UseRSI2 ==false)
  {
  UseRSI2 =true;
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_UseRSI2",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseRSI2" && UseRSI2 ==true)
  {
  UseRSI2=false;
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseRSI2",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI2",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_UseRSI3" && UseRSI3 ==false)
  {
  UseRSI3 =true;
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_UseRSI3",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseRSI3" && UseRSI3 ==true)
  {
  UseRSI3=false;
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseRSI3",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI3",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_MACD1" && trigger_MACD1 ==false)
  {
  trigger_MACD1 =true;
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_MACD1",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_MACD1" && trigger_MACD1 ==true)
  {
  trigger_MACD1=false;
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_MACD1",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_MACD2" && trigger_MACD2 ==false)
  {
  trigger_MACD2 =true;
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_MACD2",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_MACD2" && trigger_MACD2 ==true)
  {
  trigger_MACD2=false;
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_MACD2",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_MACD3" && trigger_MACD3 ==false)
  {
  trigger_MACD3 =true;
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_MACD3",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_MACD3" && trigger_MACD3 ==true)
  {
  trigger_MACD3=false;
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_MACD3",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_STATE,false);
  }
  
  if(sparam=="button_trigger_Candle_Direction" && trigger_Candle_Direction ==false)
  {
  trigger_Candle_Direction =true;
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_COLOR,DarkGreen);
  ObjectSetString(0,"button_trigger_Candle_Direction",OBJPROP_TEXT,"ON");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_Direction" && trigger_Candle_Direction ==true)
  {
  trigger_Candle_Direction=false;
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_Direction",OBJPROP_TEXT,".");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_STATE,false);
  }
//SESSOES
  if(sparam=="button_UseSession1" && UseSession1 ==false)//LONDRES
  {
  UseSession1 =true;
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_BGCOLOR,DarkGreen);
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession1",OBJPROP_TEXT,"ABERTO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession1" && UseSession1 ==true)
  {
  UseSession1=false;
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession1",OBJPROP_TEXT,"FECHADO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession1",OBJPROP_STATE,false);
  }
//--   
  if(sparam=="button_UseSession2" && UseSession2 ==false)//TOKIO
  {
  UseSession2 =true;
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_BGCOLOR,DarkGreen);
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession2",OBJPROP_TEXT,"ABERTO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession2" && UseSession2 ==true)
  {
  UseSession2=false;
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession2",OBJPROP_TEXT,"FECHADO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession2",OBJPROP_STATE,false);
  }
//--   
  if(sparam=="button_UseSession3" && UseSession3 ==false)//NOVA YORK
  {
  UseSession3 =true;
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_BGCOLOR,DarkGreen);
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession3",OBJPROP_TEXT,"ABERTO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession3" && UseSession3 ==true)
  {
  UseSession3=false;
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession3",OBJPROP_TEXT,"FECHADO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession3",OBJPROP_STATE,false);
  }            
//--   
  if(sparam=="button_UseSession4" && UseSession4 ==false)//NOVA YORK
  {
  UseSession4 =true;
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_BGCOLOR,DarkGreen);
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession4",OBJPROP_TEXT,"ABERTO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession4",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession4" && UseSession4 ==true)
  {
  UseSession4=false;
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession4",OBJPROP_TEXT,"FECHADO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession4",OBJPROP_STATE,false);
  }
  //---   
  if(sparam=="button_UseSession5" && UseSession5 ==false)//NOVA YORK
  {
  UseSession5 =true;
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_BGCOLOR,DarkGreen);
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession5",OBJPROP_TEXT,"ABERTO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession5",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession5" && UseSession5 ==true)
  {
  UseSession5=false;
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession5",OBJPROP_TEXT,"FECHADO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession5",OBJPROP_STATE,false);
  }
  //---   
  if(sparam=="button_UseSession6" && UseSession6 ==false)//NOVA YORK
  {
  UseSession6 =true;
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_BGCOLOR,DarkGreen);
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession6",OBJPROP_TEXT,"ABERTO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession6",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession6" && UseSession6 ==true)
  {
  UseSession6=false;
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession6",OBJPROP_TEXT,"FECHADO");
  Sleep(100);ObjectSetInteger(0,"button_UseSession6",OBJPROP_STATE,false);
  }
  //---   
  if(sparam=="button_trigger_use_Strength" && trigger_use_Strength ==false)//USD
  {
  trigger_use_Strength =true;
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_BGCOLOR,DarkGreen);
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_Strength",OBJPROP_TEXT,"USD");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_Strength" && trigger_use_Strength ==true)
  {
  trigger_use_Strength=false;
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_Strength",OBJPROP_TEXT,"USD");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_STATE,false);
  }                                                     
//SESSOES                        
//---------------------------------------------------------------------
  

/* //--------------------------------------------------------------------------------------------------------
       if(sparam==button_SB1)//plus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB1,OBJPROP_TEXT,"Increase Hare LOT value...");
            S_BS_Lot=S_BS_Lot+.01;
            ObjectDelete(button_SB1);         
         }
       if(sparam==button_SB2)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB2,OBJPROP_TEXT,"Decrease Hare LOT value...");
            S_BS_Lot=S_BS_Lot-.01;
            if(S_BS_Lot<0.01){S_BS_Lot=0.01;}
            ObjectDelete(button_SB2);         
         }
//+++++++++
       if(sparam==button_SB3)//plus button for Single & Basket LOT value-00.X0
         {
            ObjectSetString(0,button_SB3,OBJPROP_TEXT,"Increase Hare LOT value...");
            S_BS_Lot=S_BS_Lot+.10;
            ObjectDelete(button_SB3);         
         }
       if(sparam==button_SB4)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB4,OBJPROP_TEXT,"Decrease TOR LOT value...");
            S_BS_Lot=S_BS_Lot-.10;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_SB4);         
         }
//++++++++++
       if(sparam==button_SB5)//plus button for Single & Basket LOT value-0X.00
         {
            ObjectSetString(0,button_SB5,OBJPROP_TEXT,"Increase HARE LOT value...");
            S_BS_Lot=S_BS_Lot+1.00;
            ObjectDelete(button_SB5);         
         }
       if(sparam==button_SB6)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB6,OBJPROP_TEXT,"Decrease HARE LOT value...");
            S_BS_Lot=S_BS_Lot-1.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_SB6);         
         }
//++++++++++
       if(sparam==button_SB7)//plus button for Single & Basket LOT value-X0.00
         {
            ObjectSetString(0,button_SB7,OBJPROP_TEXT,"Increase HARE LOT value...");
            S_BS_Lot=S_BS_Lot+10.00;
            ObjectDelete(button_SB7);         
         }
       if(sparam==button_SB8)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB8,OBJPROP_TEXT,"Decrease HARE LOT value...");
            S_BS_Lot=S_BS_Lot-10.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_SB8);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_SB9)//plus button for Single & Basket TP value
         {
            ObjectSetString(0,button_SB9,OBJPROP_TEXT,"Increase Hare TP value...");
            S_BS_TP=S_BS_TP+5;
            ObjectDelete(button_SB9);         
         }      
       if(sparam==button_SB10)//minus button for Single & Basket TP value
         {
            ObjectSetString(0,button_SB10,OBJPROP_TEXT,"Decrease Hare TP value...");
            S_BS_TP=S_BS_TP-5;
            if(S_BS_TP<0){S_BS_TP=0;}
            ObjectDelete(button_SB10);         
         }
//+-----------------------------------------------------------------------------
       if(sparam==button_SB11)//plus button for Single & Basket SL value
         {
            ObjectSetString(0,button_SB11,OBJPROP_TEXT,"Increase Hare TP value...");
            S_BS_SL=S_BS_SL+5;
            ObjectDelete(button_SB11);         
         }      
       if(sparam==button_SB12)//minus button for Single & Basket SL value
         {
            ObjectSetString(0,button_SB12,OBJPROP_TEXT,"Decrease Hare TP value...");
            S_BS_SL=S_BS_SL-5;
            if(S_BS_SL<0){S_BS_SL=0;}
            ObjectDelete(button_SB12);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_H1)//plus button for HARE LOT value
         {
            ObjectSetString(0,button_H1,OBJPROP_TEXT,"Increase Hare LOT value...");
            H_Lot=H_Lot+.01;
            ObjectDelete(button_H1);         
         }
       if(sparam==button_H2)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H2,OBJPROP_TEXT,"Decrease Hare LOT value...");
            H_Lot=H_Lot-.01;
            if(H_Lot<0.01){H_Lot=0.01;}
            ObjectDelete(button_H2);         
         }
//+++++++++
       if(sparam==button_H3)//plus button for HARE LOT value-00.X0
         {
            ObjectSetString(0,button_H3,OBJPROP_TEXT,"Increase Hare LOT value...");
            H_Lot=H_Lot+.10;
            ObjectDelete(button_H3);         
         }
       if(sparam==button_H4)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H4,OBJPROP_TEXT,"Decrease TOR LOT value...");
            H_Lot=H_Lot-.10;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_H4);         
         }
//++++++++++
       if(sparam==button_H5)//plus button for TORTOISE LOT value-0X.00
         {
            ObjectSetString(0,button_H5,OBJPROP_TEXT,"Increase HARE LOT value...");
            H_Lot=H_Lot+1.00;
            ObjectDelete(button_H5);         
         }
       if(sparam==button_H6)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H6,OBJPROP_TEXT,"Decrease HARE LOT value...");
            H_Lot=H_Lot-1.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_H6);         
         }
//++++++++++
       if(sparam==button_H7)//plus button for HARE LOT value-X0.00
         {
            ObjectSetString(0,button_H7,OBJPROP_TEXT,"Increase HARE LOT value...");
            H_Lot=H_Lot+10.00;
            ObjectDelete(button_H7);         
         }
       if(sparam==button_H8)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H8,OBJPROP_TEXT,"Decrease HARE LOT value...");
            H_Lot=H_Lot-10.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_H8);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_H9)//plus button for HARE TP value
         {
            ObjectSetString(0,button_H9,OBJPROP_TEXT,"Increase Hare TP value...");
            H_TP=H_TP+5;
            ObjectDelete(button_H9);         
         }      
       if(sparam==button_H10)//minus button for HARE TP value
         {
            ObjectSetString(0,button_H10,OBJPROP_TEXT,"Decrease Hare TP value...");
            H_TP=H_TP-5;
            if(H_TP<0){H_TP=0;}
            ObjectDelete(button_H10);         
         }
//+-----------------------------------------------------------------------------
       if(sparam==button_H11)//plus button for HARE SL value
         {
            ObjectSetString(0,button_H11,OBJPROP_TEXT,"Increase Hare TP value...");
            H_SL=H_SL+5;
            ObjectDelete(button_H11);         
         }      
       if(sparam==button_H12)//minus button for HARE SL value
         {
            ObjectSetString(0,button_H12,OBJPROP_TEXT,"Decrease Hare TP value...");
            H_SL=H_SL-5;
            if(H_SL<0){H_SL=0;}
            ObjectDelete(button_H12);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_T1)//plus button for TORTOISE LOT value-00.0X
         {
            ObjectSetString(0,button_T1,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+.01;
            ObjectDelete(button_T1);         
         }
       if(sparam==button_T2)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T2,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-.01;
            if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T2);         
         }
//++++++++++
       if(sparam==button_T3)//plus button for TORTOISE LOT value-00.X0
         {
            ObjectSetString(0,button_T3,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+.10;
            ObjectDelete(button_T3);         
         }
       if(sparam==button_T4)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T4,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-.10;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T4);         
         }
//++++++++++
       if(sparam==button_T5)//plus button for TORTOISE LOT value-0X.00
         {
            ObjectSetString(0,button_T5,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+1.00;
            ObjectDelete(button_T5);         
         }
       if(sparam==button_T6)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T6,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-1.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T6);         
         }
//++++++++++
       if(sparam==button_T7)//plus button for TORTOISE LOT value-X0.00
         {
            ObjectSetString(0,button_T7,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+10.00;
            ObjectDelete(button_T7);         
         }
       if(sparam==button_T8)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T8,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-10.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T8);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_T9)//plus button for TORTOISE TP value
         {
            ObjectSetString(0,button_T9,OBJPROP_TEXT,"Increase Tort TP value...");
            TOR_TP=TOR_TP+5;
            ObjectDelete(button_T9);         
         }      
       if(sparam==button_T10)//minus button for TORT TP value
         {
            ObjectSetString(0,button_T10,OBJPROP_TEXT,"Decrease Tort TP value...");
            TOR_TP=TOR_TP-5;
            if(TOR_TP<0){TOR_TP=0;}
            ObjectDelete(button_T10);         
         }
//+-----------------------------------------------------------------------------
       if(sparam==button_T11)//plus button for TORT SL value
         {
            ObjectSetString(0,button_T11,OBJPROP_TEXT,"Increase Tort TP value...");
            TOR_SL=TOR_SL+5;
            ObjectDelete(button_T11);         
         }      
       if(sparam==button_T12)//minus button for TORT SL value
         {
            ObjectSetString(0,button_T12,OBJPROP_TEXT,"Decrease Tort TP value...");
            TOR_SL=TOR_SL-5;
            if(TOR_SL<0){TOR_SL=0;}
            ObjectDelete(button_T12);         
       //  }

//--------------------------------------------------------------------------------------------------------        
   //  }
    //--- re-draw property values
   //ChartRedraw(); 
     }*/ 
  //{
  if (sparam==button_AUD_basket_buy)
  {          
  buy_basket(AUD);
  sell_basket(AUD_R);
  ObjectSetInteger(0,button_AUD_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_AUD_basket_sell)
  {          
  sell_basket(AUD);
  buy_basket(AUD_R);
  ObjectSetInteger(0,button_AUD_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_CAD_basket_buy)
  {          
  buy_basket(CAD);
  sell_basket(CAD_R);
  ObjectSetInteger(0,button_CAD_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_CAD_basket_sell)
  {          
  sell_basket(CAD);
  buy_basket(CAD_R);
  ObjectSetInteger(0,button_CAD_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_CHF_basket_buy)
  {          
  buy_basket(CHF);
  sell_basket(CHF_R);
  ObjectSetInteger(0,button_CHF_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_CHF_basket_sell)
  {          
  sell_basket(CHF);
  buy_basket(CHF_R);
  ObjectSetInteger(0,button_CHF_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_EUR_basket_buy)
  {          
  buy_basket(EUR);
  ObjectSetInteger(0,button_EUR_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_EUR_basket_sell)
  {          
  sell_basket(EUR);
  ObjectSetInteger(0,button_EUR_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_GBP_basket_buy)
  {          
  buy_basket(GBP);
  sell_basket(GBP_R);
  ObjectSetInteger(0,button_GBP_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_GBP_basket_sell)
  {          
  sell_basket(GBP);
  buy_basket(GBP_R);
  ObjectSetInteger(0,button_GBP_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_JPY_basket_buy)
  {          
  sell_basket(JPY_R);
  ObjectSetInteger(0,button_JPY_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_JPY_basket_sell)
  {          
  buy_basket(JPY_R);
  ObjectSetInteger(0,button_JPY_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_NZD_basket_buy)
  {          
  buy_basket(NZD);
  sell_basket(NZD_R);
  ObjectSetInteger(0,button_NZD_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_NZD_basket_sell)
  {          
  sell_basket(NZD);
  buy_basket(NZD_R);
  ObjectSetInteger(0,button_NZD_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_USD_basket_buy)
  {          
  buy_basket(USD);
  sell_basket(USD_R);
  ObjectSetInteger(0,button_USD_basket_buy,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------  
  if (sparam==button_USD_basket_sell)
  {          
  sell_basket(USD);
  buy_basket(USD_R);
  ObjectSetInteger(0,button_USD_basket_sell,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_AUD_basket_close)
  {          
  close_cur_basket(AUD);
  close_cur_basket(AUD_R);
  ObjectSetInteger(0,button_AUD_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_CAD_basket_close)
  {          
  close_cur_basket(CAD);
  close_cur_basket(CAD_R);
  ObjectSetInteger(0,button_CAD_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_CHF_basket_close)
  {          
  close_cur_basket(CHF);
  close_cur_basket(CHF_R);
  ObjectSetInteger(0,button_CHF_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_EUR_basket_close)
  {          
  close_cur_basket(EUR);
  ObjectSetInteger(0,button_EUR_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_GBP_basket_close)
  {          
  close_cur_basket(GBP);
  close_cur_basket(GBP_R);
  ObjectSetInteger(0,button_GBP_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_JPY_basket_close)
  {          
  close_cur_basket(JPY_R);
  ObjectSetInteger(0,button_JPY_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_NZD_basket_close)
  {          
  close_cur_basket(NZD);
  close_cur_basket(NZD_R);
  ObjectSetInteger(0,button_NZD_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_USD_basket_close)
  {          
  close_cur_basket(USD);
  close_cur_basket(USD_R);
  ObjectSetInteger(0,button_USD_basket_close,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_reset_ea)
  {          
  Reset_EA();
  ObjectSetInteger(0,button_reset_ea,OBJPROP_STATE,0);
  return;
  }
//-----------------------------------------------------------------------------------------------------------------
  if (sparam==button_close_basket_All)
  {
  ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Closing...");               
  close_basket(Magic_Number);
  ObjectSetInteger(0,button_close_basket_All,OBJPROP_STATE,0);
  ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Close Basket"); 
  return;
  }
//-----------------------------------------------------------------------------------------------------------------     
  if (sparam==button_close_basket_Prof)
  {
  ObjectSetString(0,button_close_basket_Prof,OBJPROP_TEXT,"Closing...");               
  close_profit();
  ObjectSetInteger(0,button_close_basket_Prof,OBJPROP_STATE,0);
  ObjectSetString(0,button_close_basket_Prof,OBJPROP_TEXT,"Close Basket"); 
  return;
  }
//----------------------------------------------------------------------------------------------------------------- 
  if (sparam==button_close_basket_Loss)
  {
  ObjectSetString(0,button_close_basket_Loss,OBJPROP_TEXT,"Closing...");               
  close_loss();
  ObjectSetInteger(0,button_close_basket_Loss,OBJPROP_STATE,0);
  ObjectSetString(0,button_close_basket_Loss,OBJPROP_TEXT,"Close Basket"); 
  return;
  }
//BOTAO LOTES
if(sparam==button_increase_lot)
  {
  lot+=lotStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_lot)
  {
  if(lot>lotStep) lot-=lotStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO LOTES 
//BOTAO STOPSPIP
if(sparam==button_increase_Piptp)
  {
  Piptp+=PiptpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Piptp)
  {
  if(Piptp>PiptpStep) Piptp-=PiptpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//---  
  if(sparam==button_increase_Pipsl)
  {
  Pipsl+=PipslStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Pipsl)
  {
  if(Pipsl>PipslStep) Pipsl-=PipslStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO STOPSPIP
/*//BOTAO STOPSADR
if(sparam==button_increase_Adr1tp)
  {
  Adr1tp+=Adr1tpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Adr1tp)
  {
  if(Adr1tp>Adr1tpStep) Adr1tp-=Adr1tpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//---  
  if(sparam==button_increase_Adr1sl)
  {
  Adr1sl+=Adr1slStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Adr1sl)
  {
  if(Adr1sl>Adr1slStep) Adr1sl-=Adr1slStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO STOPSADR*/  
       
//-----------------------------------------------------------------------------------------------------------------
  if (StringFind(sparam,"BUY") >= 0)
  {
  int ind = StringToInteger(sparam);
  ticket=OrderSend(DefaultPairs[ind],OP_BUY,lot,MarketInfo(DefaultPairs[ind],MODE_ASK),100,0,0,"Trade Manual",Magic_Number,0,Blue);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true)
  {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() - Pipsl * pairinfo[ind].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice() - ((adrvalues[ind].adr10/100)*Adr1sl) * pairinfo[ind].PairPip;
  else
  stoploss = 0.0;
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() + Piptp * pairinfo[ind].PairPip;
  else
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() + ((adrvalues[ind].adr10/100)*Adr1tp) * pairinfo[ind].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(DefaultPairs[ind],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(DefaultPairs[ind],MODE_DIGITS)),0,clrBlue);
  }
  ObjectSetInteger(0,ind+"BUY",OBJPROP_STATE,0);
  ObjectSetString(0,ind+"BUY",OBJPROP_TEXT,"BUY"); 
  return;
  }
  if (StringFind(sparam,"SELL") >= 0)
  {
  int ind = StringToInteger(sparam);
  ticket=OrderSend(DefaultPairs[ind],OP_SELL,lot,MarketInfo(DefaultPairs[ind],MODE_BID),100,0,0,"Trade Manual",Magic_Number,0,Red);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() + Pipsl * pairinfo[ind].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice()+((adrvalues[ind].adr10/100)*Adr1sl)  *pairinfo[ind].PairPip;
  else
  stoploss = 0.0;
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() - Piptp * pairinfo[ind].PairPip;
  else 
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() - ((adrvalues[ind].adr10/100)*Adr1tp) * pairinfo[ind].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(DefaultPairs[ind],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(DefaultPairs[ind],MODE_DIGITS)),0,clrBlue);
  }
  ObjectSetInteger(0,ind+"SELL",OBJPROP_STATE,0);
  ObjectSetString(0,ind+"SELL",OBJPROP_TEXT,"SELL");
  return;
  }
  if (StringFind(sparam,"CLOSE") >= 0)
  {
  int ind = StringToInteger(sparam);
  closeOpenOrders(DefaultPairs[ind]);               
  ObjectSetInteger(0,ind+"CLOSE",OBJPROP_STATE,0);
  ObjectSetString(0,ind+"CLOSE",OBJPROP_TEXT,"CLOSE");
  return;
  }
  if (StringFind(sparam,"Pair") >= 0)
  {
  int ind = StringToInteger(sparam);
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  OpenChart(ind);
  return;         
  }   
  }
  //}
void buy_basket(string &pairs[])
  {
  int i;
  int ticket;
   
  for(i=0;i<ArraySize(pairs);i++)
  {
  ticket=OrderSend(pairs[i],OP_BUY,lot,MarketInfo(pairs[i],MODE_ASK),100,0,0,NULL,Magic_Number,0,clrNONE);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() - Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1sl) * pairinfo[i].PairPip;
  else
  stoploss = 0.0;
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() + Piptp * pairinfo[i].PairPip;
  else
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() + ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(pairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(pairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  }

  void sell_basket(string &pairs[])
  {
  int i;
  int ticket;
  for(i=0;i<ArraySize(pairs);i++)
  {
  ticket=OrderSend(pairs[i],OP_SELL,lot,MarketInfo(pairs[i],MODE_BID),100,0,0,NULL,Magic_Number,0,clrNONE);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() + Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice()+((adrvalues[i].adr10/100)*Adr1sl)  *pairinfo[i].PairPip;
  else
  stoploss = 0.0;
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() - Piptp * pairinfo[i].PairPip;
  else 
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(pairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(pairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  }
void close_cur_basket(string &pairs[])
  { 
  if (OrdersTotal() <= 0)
  return;
  int TradeList[][2];
  int ctTrade = 0;
  for (int i=0; i<OrdersTotal(); i++) 
  {
  OrderSelect(i, SELECT_BY_POS);
  if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true &&
  (OrderType()==0 || OrderType()==1) && 
  OrderMagicNumber()==Magic_Number &&
  InArray(pairs, OrderSymbol())) 
  {
  ctTrade++;
  ArrayResize(TradeList, ctTrade);
  TradeList[ctTrade-1][0] = OrderOpenTime();
  TradeList[ctTrade-1][1] = OrderTicket();
  }
  }
  ArraySort(TradeList,WHOLE_ARRAY,0,MODE_ASCEND);
  for (int i=0;i<ctTrade;i++) 
  {
  if (OrderSelect(TradeList[i][1], SELECT_BY_TICKET)==true) 
  {
  if (OrderType()==0)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_BID), 100, clrNONE);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  }
  if (OrderType()==1)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_ASK), 100, clrNONE);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  
  }  
  }
         Sleep(500);
  }  
  }


//+------------------------------------------------------------------+
//| closeOpenOrders                                                  |
//+------------------------------------------------------------------+
void closeOpenOrders(string closecurr )
  {
  int cnt = 0;  
  for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
  {
  if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
  {
  if(OrderType()==OP_BUY && OrderSymbol() == closecurr && OrderMagicNumber()==Magic_Number)
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
  else if(OrderType()==OP_SELL && OrderSymbol() == closecurr && OrderMagicNumber()==Magic_Number) 
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
  else if(OrderType()>OP_SELL) //pending orders
  ticket=OrderDelete(OrderTicket());
  }
  }
  }
void close_basket(int magic_number)
  { 
  if (OrdersTotal() <= 0)
  return;
  int TradeList[][2];
  int ctTrade = 0;
  for (int i=0; i<OrdersTotal(); i++) 
  {
  OrderSelect(i, SELECT_BY_POS);
  if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true && (OrderType()==0 || OrderType()==1) && OrderMagicNumber()==Magic_Number)
  {
  ctTrade++;
  ArrayResize(TradeList, ctTrade);
  TradeList[ctTrade-1][0] = OrderOpenTime();
  TradeList[ctTrade-1][1] = OrderTicket();
  }
  }
ArraySort(TradeList,WHOLE_ARRAY,0,MODE_ASCEND);
  for (int i=0;i<ctTrade;i++) 
  {
  if (OrderSelect(TradeList[i][1], SELECT_BY_TICKET)==true)
  {
  if (OrderType()==0)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_BID), 3,Red);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  }
  if (OrderType()==1)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_ASK), 3,Red);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  }  
  }
  }
  for (int i=0;i<ArraySize(DefaultPairs);i++)
  pairinfo[i].lastSignal = NOTHING; 
  currentlock = 0.0;
  trailstarted = false;   
  lockdistance = 0.0;    
  SymbolMaxDD = 0;
  SymbolMaxHi = 0;
  PercentFloatingSymbol=0;
  PercentMaxDDSymbol=0;    
  }
void close_profit()
  {
  int cnt = 0; 
  for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
  {
  if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
  if (OrderProfit() > 0)
  {
  if(OrderType()==OP_BUY && OrderMagicNumber()==Magic_Number)
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
  if(OrderType()==OP_SELL && OrderMagicNumber()==Magic_Number) 
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
  if(OrderType()>OP_SELL)
  ticket=OrderDelete(OrderTicket());
  }
  } 
  }
void close_loss()
  {
  int cnt = 0; 
  for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
  {
  if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
  if (OrderProfit() < 0)
  {
  if(OrderType()==OP_BUY && OrderMagicNumber()==Magic_Number)
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
  if(OrderType()==OP_SELL && OrderMagicNumber()==Magic_Number) 
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
  if(OrderType()>OP_SELL)
  ticket=OrderDelete(OrderTicket());
  }
  } 
  } 

void Reset_EA()
  {
  currentlock = 0.0;
  trailstarted = false;   
  lockdistance = 0.0;    
  SymbolMaxDD = 0;
  SymbolMaxHi = 0;
  PercentFloatingSymbol=0;
  PercentMaxDDSymbol=0;
  OnInit();
  }
//+------------------------------------------------------------------+
void Trades()
  {
  int i, j;
  totallots=0;
  totalprofit=0;
  totaltrades = 0;
  
  for(i=0;i<ArraySize(DefaultPairs);i++)
  {
  bpos[i]=0;
  spos[i]=0;       
  blots[i]=0;
  slots[i]=0;     
  bprofit[i]=0;
  sprofit[i]=0;
  tprofit[i]=0;
  }
  for(i=0;i<OrdersTotal();i++)
  {
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
  break;
  for(j=0;j<ArraySize(DefaultPairs);j++)
  {	  
  if((DefaultPairs[j]==OrderSymbol() || DefaultPairs[j]=="") && OrderMagicNumber()==Magic_Number)
  {
  DefaultPairs[j]=OrderSymbol();                       
  tprofit[j]=tprofit[j]+OrderProfit()+OrderSwap()+OrderCommission();
  if(OrderType()==0){ bprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission();
  } 
  if(OrderType()==1){ sprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission();
  } 
  if(OrderType()==0){ blots[j]+=OrderLots();
  } 
  if(OrderType()==1){ slots[j]+=OrderLots();
  }
  if(OrderType()==0){ bpos[j]+=+1;
  } 
  if(OrderType()==1){ spos[j]+=+1;
  } 
  totallots=totallots+OrderLots();
  totaltrades++;
  totalprofit = totalprofit+OrderProfit()+OrderSwap()+OrderCommission();
  break;
  }
  }
  }
  if(OrdersTotal()==0)
  SetText("CTP","Sem Trades no Monitor",x_axis+315,y_axis+455,clrNONE,8);
  else
  SetText("CTP","Monitor Trades",x_axis+315,y_axis+455,clrNONE,8);
  if (inSession() == true)
  SetText("CTPT","Mercado aberto",x_axis+315,y_axis+415,clrLime,8);
  else
  SetText("CTPT","Mercado fechado",x_axis+315,y_axis+415,clrRed,8);
//SetPanel("TP6",0,x_axis+95,y_axis-50,100,20,Black,White,1);
  }
//+------------------------------------------------------------------+ 
void OpenChart(int ind)
  {
  long nextchart = ChartFirst();
  do
  {
  string sym = ChartSymbol(nextchart);
  if (StringFind(sym,DefaultPairs[ind]) >= 0) 
  {
  ChartSetInteger(nextchart,CHART_BRING_TO_TOP,true);
  ChartSetSymbolPeriod(nextchart,DefaultPairs[ind],TimeFrame);
  ChartApplyTemplate(nextchart,usertemplate);
  return;
  }
  } 
  while ((nextchart = ChartNext(nextchart)) != -1);
  long newchartid = ChartOpen(DefaultPairs[ind],TimeFrame);
  ChartApplyTemplate(newchartid,usertemplate);
  }
//+------------------------------------------------------------------+  
void TradeManager()
  {
  double AccBalance=AccountBalance();
  //- Target
  if(Basket_Target>0 && totalprofit>=Basket_Target) 
  {
  profitbaskets++;
  close_basket(Magic_Number);
  return;
  }
  //- StopLoss
  if(Basket_StopLoss>0 && totalprofit<(0-Basket_StopLoss)) 
  {
  lossbaskets++;
  close_basket(Magic_Number);
  return;
  }
  //- Out off session
  if(inSession() == false && totallots > 0.0 && CloseAllSession == true)
  {
  close_basket(Magic_Number);
  return;
  }
  
  //- Profit lock stoploss
  if (currentlock != 0.0 && totalprofit < currentlock)
  {
  profitbaskets++;
  close_basket(Magic_Number);
  return;
  }
  //- Profit lock trail
  if (trailstarted == true && totalprofit > currentlock + lockdistance)
  currentlock = totalprofit - lockdistance;
  //- Lock in profit 1
  if (BasketP1 != 0.0 && BasketL1 != 0.0 && currentlock < BasketL1) 
  {
  if (totalprofit > BasketP1)
  currentlock = BasketL1;
  if (BasketP2 == 0.0 && TrailLastLock == true) 
  {
  trailstarted = true;
  if (TrailDistance != 0.0)
  lockdistance = BasketP1 - TrailDistance;
  else
  lockdistance = BasketL1;
  }
  }
  //- Lock in profit 2
  if (BasketP2 != 0.0 && BasketL2 != 0.0 && currentlock < BasketL2)
  {
  if (totalprofit > BasketP2)
  currentlock = BasketL2;
  if (BasketP3 == 0.0 && TrailLastLock == true)
  {
  trailstarted = true;
  if (TrailDistance != 0.0)
  lockdistance = BasketP2 - TrailDistance;
  else
  lockdistance = BasketL2;
  }
  }
  //- Lock in profit 3
  if (BasketP3 != 0.0 && BasketL3 != 0.0 && currentlock < BasketL3)
  {
  if (totalprofit > BasketP3)
  currentlock = BasketL3;
  if (BasketP4 == 0.0 && TrailLastLock == true)
  {
  trailstarted = true;
  if (TrailDistance != 0.0)
  lockdistance = BasketP3 - TrailDistance;
  else
  lockdistance = BasketL3;
  }
  }
  //- Lock in profit 4
  if (BasketP4 != 0.0 && BasketL4 != 0.0 && currentlock < BasketL4)
  {
  if (totalprofit > BasketP4)
  currentlock = BasketL4;
  if (BasketP5 == 0.0 && TrailLastLock == true) 
  {
  trailstarted = true;
  if (TrailDistance != 0.0)
  lockdistance = BasketP4 - TrailDistance;
  else
  lockdistance = BasketL4;
  }
  }
  //- Lock in profit 5
  if (BasketP5 != 0.0 && BasketL5 != 0.0 && currentlock < BasketL5) 
  {
  if (totalprofit > BasketP5)
  currentlock = BasketL5;
  if (BasketP6 == 0.0 && TrailLastLock == true)
  {
  trailstarted = true;
  if (TrailDistance != 0.0)
  lockdistance = BasketP5 - TrailDistance;
  else
  lockdistance = BasketL5;
  }
  }
  //- Lock in profit 6
  if (BasketP6 != 0.0 && BasketL6 != 0.0 && currentlock < BasketL6)
  {
  if (totalprofit > BasketP6)
  currentlock = BasketL6;
  if (TrailLastLock == true) {
  trailstarted = true;
  if (TrailDistance != 0.0)
  lockdistance = BasketP6 - TrailDistance;
  else
  lockdistance = BasketL6;
  }
  }
  if(totalprofit<=SymbolMaxDD) 
  {
  SymbolMaxDD=totalprofit;
  GetBalanceSymbol=AccBalance;
  }
  if(GetBalanceSymbol != 0)
  PercentMaxDDSymbol=(SymbolMaxDD*100)/GetBalanceSymbol;
  
  if(totalprofit>=SymbolMaxHi) 
  {
  SymbolMaxHi=totalprofit;
  GetBalanceSymbol=AccBalance;
  }
  if(GetBalanceSymbol != 0)
  PercentFloatingSymbol=(SymbolMaxHi*100)/GetBalanceSymbol;
  
  ObjectSetText("Lowest","Lowest= "+DoubleToStr(SymbolMaxDD,2)+" ("+DoubleToStr(PercentMaxDDSymbol,2)+"%)",8,NULL,BearColor);
  ObjectSetText("Highest","Highest= "+DoubleToStr(SymbolMaxHi,2)+" ("+DoubleToStr(PercentFloatingSymbol,2)+"%)",8,NULL,BullColor);
  ObjectSetText("Lock","Lock= "+DoubleToStr(currentlock,2),8,NULL,BullColor);
  ObjectSetText("Won",IntegerToString(profitbaskets,2),8,NULL,BullColor);
  ObjectSetText("Lost",IntegerToString(lossbaskets,2),8,NULL,BearColor);
  }
//SIGNAL USD
void SetColors(int i) 
  {
  if(signals[i].Signalm1==1){Color=BullColor;}
  if(signals[i].Signalm1==-1){Color=BearColor;}
  if(signals[i].Signalm5==1){Color1=BullColor;}         
  if(signals[i].Signalm5==-1){Color1 =BearColor;}
  if(signals[i].Signalm15==1){Color2 =BullColor;}
  if(signals[i].Signalm15==-1){Color2=BearColor;}
  if(signals[i].Signalm30==1){Color3=BullColor;}
  if(signals[i].Signalm30==-1){Color3=BearColor;}
  if(signals[i].Signalh1==1){Color4=BullColor;}
  if(signals[i].Signalh1==-1){Color4=BearColor;}
  if(signals[i].Signalh4==1){Color5=BullColor;}
  if(signals[i].Signalh4==-1){Color5=BearColor;}
  if(signals[i].Signald1==1){Color6=BullColor;}
  if(signals[i].Signald1==-1){Color6=BearColor;}
  if(signals[i].Signalw1==1){Color7=BullColor;}
  if(signals[i].Signalw1==-1){Color7=BearColor;}
  if(signals[i].Signalmn==1){Color8=BullColor;}
  if(signals[i].Signalmn==-1){Color8=BearColor;}
  if(signals[i].Signalusd>0){Color9=BullColor;}
  if(signals[i].Signalusd<0){Color9=BearColor;}
  if(signals[i].Signalperc>0){Color12=BullColor;}
  if(signals[i].Signalperc<0){Color12=BearColor;}
  
  if(signals[i].Signalusd>0){Color9=BullColor;}
  if(signals[i].Signalusd<0){Color9=BearColor;}
  if(signals[i].Signalperc>0){Color12=BullColor;}
  if(signals[i].Signalperc<0){Color12=BearColor;}
  
  if(signals[i].Signalusd>0.0)labelcolor1=clrGreen;     
  else if(signals[i].Signalusd<0.0)labelcolor1=clrRed;
  if(signals[i].Signalusd>10.0)labelcolor3=clrGreen;     
  else if(signals[i].Signalusd<-10.0)labelcolor3=clrRed;
  else labelcolor3=C'20,20,20'; 
  if(signals[i].Signalusd>20.0)labelcolor4=clrGreen;     
  else if(signals[i].Signalusd<-20.0)labelcolor4=clrRed;
  else labelcolor4=C'20,20,20';  
  if(signals[i].Signalusd>30.0)labelcolor5=clrGreen;     
  else if(signals[i].Signalusd<-30.0)labelcolor5=clrRed;
  else labelcolor5=C'20,20,20'; 
  if(signals[i].Signalusd>40.0)labelcolor6=clrGreen;     
  else if(signals[i].Signalusd<-40.0)labelcolor6=clrRed;
  else labelcolor6=C'20,20,20'; 
  if(signals[i].Signalusd>50.0)labelcolor7=clrGreen;     
  else if(signals[i].Signalusd<-50.0)labelcolor7=clrRed;
  else labelcolor7=C'20,20,20'; 
  if(signals[i].Signalusd>60.0)labelcolor8=clrGreen;     
  else if(signals[i].Signalusd<-60.0)labelcolor8=clrRed;
  else labelcolor8=C'20,20,20'; 
  if(signals[i].Signalusd>70.0)labelcolor9=clrGreen;     
  else if(signals[i].Signalusd<-70.0)labelcolor9=clrRed;
  else labelcolor9=C'20,20,20'; 
  if(signals[i].Signalusd>80.0)labelcolor10=clrGreen;     
  else if(signals[i].Signalusd<-80.0)labelcolor10=clrRed;
  else labelcolor10=C'20,20,20';  
  if(signals[i].Signalusd>90.0)labelcolor11=clrGreen;     
  else if(signals[i].Signalusd<-90.0)labelcolor11=clrRed;
  else labelcolor11=C'20,20,20';    
  }
//SIGNAL USD       
void PlotTrades()
  {
  for (int i=0; i<ArraySize(DefaultPairs);i++)
  {
  if(blots[i]>0){LotColor =clrLime;
  }        
  if(blots[i]==0){LotColor =C'61,61,61';
  }
  if(slots[i]>0){LotColor1 =clrRed;
  }        
  if(slots[i]==0){LotColor1 =C'61,61,61';
  }
  if(bpos[i]>0){OrdColor =DodgerBlue;
  }        
  if(bpos[i]==0){OrdColor =C'61,61,61';
  }
  if(spos[i]>0){OrdColor1 =DodgerBlue;
  }        
  if(spos[i]==0){OrdColor1 =C'61,61,61';
  }
  if(bprofit[i]>0){ProfitColor =BullColor;
  }
  if(bprofit[i]<0){ProfitColor =BearColor;
  }
  if(bprofit[i]==0){ProfitColor =C'61,61,61';
  }
  if(sprofit[i]>0){ProfitColor2 =BullColor;
  }
  if(sprofit[i]<0){ProfitColor2 =BearColor;
  }
  if(sprofit[i]==0){ProfitColor2 =C'61,61,61';
  }
  if(tprofit[i]>0){ProfitColor3 =clrLime;
  }
  if(tprofit[i]<0){ProfitColor3 =clrRed;
  }
  if(tprofit[i]==0){ProfitColor3 =C'61,61,61';
  }
  if(totalprofit>0){ProfitColor1 =clrLime;
  }
  if(totalprofit<0){ProfitColor1 =clrRed;
  }
  if(totalprofit==0){ProfitColor1 =clrWhite;
  }
  ObjectSetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),8,NULL,LotColor);
  ObjectSetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),8,NULL,LotColor1);
  ObjectSetText("bPos"+IntegerToString(i),DoubleToStr(bpos[i],0),8,NULL,OrdColor);
  ObjectSetText("sPos"+IntegerToString(i),DoubleToStr(spos[i],0),8,NULL,OrdColor1);
  ObjectSetText("TProf"+IntegerToString(i),DoubleToStr(MathAbs(bprofit[i]),2),8,NULL,ProfitColor);
  ObjectSetText("SProf"+IntegerToString(i),DoubleToStr(MathAbs(sprofit[i]),2),8,NULL,ProfitColor2);
  ObjectSetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),8,NULL,ProfitColor3);
  ObjectSetText("TotProf",DoubleToStr(MathAbs(totalprofit),2),15,NULL,ProfitColor1);
  }
  }
void PlotAdrValues()
  {
  for (int i=0;i<ArraySize(DefaultPairs);i++)
  ObjectSetText("S1"+IntegerToString(i),DoubleToStr(adrvalues[i].adr,0),8,NULL,Yellow);
  }
bool inSession()
  {
  if ((localday != TimeDayOfWeek(TimeLocal()) && s1active == false && s2active == false && s3active == false && s4active == false && s5active == false && s6active == false) || localday == 99)
  {
  TimeToStruct(TimeLocal(),sess);
  StringSplit(sess1start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s1start = StructToTime(sess);
  StringSplit(sess1end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s1end = StructToTime(sess);
  StringSplit(sess2start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s2start = StructToTime(sess);
  StringSplit(sess2end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s2end = StructToTime(sess);
  StringSplit(sess3start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s3start = StructToTime(sess);
  StringSplit(sess3end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s3end = StructToTime(sess);
  StringSplit(sess4start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s4start = StructToTime(sess);
  StringSplit(sess4end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s4end = StructToTime(sess);
  StringSplit(sess5start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s5start = StructToTime(sess);
  StringSplit(sess5end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s5end = StructToTime(sess);
  StringSplit(sess6start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s6start = StructToTime(sess);
  StringSplit(sess6end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s6end = StructToTime(sess);
  
  if (s1end < s1start)
  s1end += 24*60*60;
  if (s2end < s2start)
  s2end += 24*60*60;
  if (s3end < s3start)
  s3end += 24*60*60;
  if (s4end < s4start)
  s4end += 24*60*60;
  if (s5end < s5start)
  s5end += 24*60*60;
  if (s6end < s6start)
  s6end += 24*60*60;
  
  newSession();
  localday = TimeDayOfWeek(TimeLocal());
  Print("Sessions for today");
  if (UseSession1 == true)
  Print("Session 1 From:"+s1start+" until "+s1end);
  if (UseSession2 == true)
  Print("Session 2 From:"+s2start+" until "+s2end);
  if (UseSession3 == true)
  Print("Session 3 From:"+s3start+" until "+s3end);
  if (UseSession4 == true)
  Print("Session 4 From:"+s4start+" until "+s4end);
  if (UseSession5 == true)
  Print("Session 5 From:"+s5start+" until "+s5end);
  if (UseSession6 == true)
  Print("Session 6 From:"+s6start+" until "+s6end);
  }

  if (UseSession1 && TimeLocal() >= s1start && TimeLocal() <= s1end)
  {
  comment = sess1comment;
  if (s1active == false)
  newSession();         
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s1active = true;
  return(true);
  }
  else
  {
  s1active = false;
  }   
  if (UseSession2 && TimeLocal() >= s2start && TimeLocal() <= s2end) 
  {
  comment = sess2comment;
  if (s2active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s2active = true;
  return(true);
  }
  else
  {
  s2active = false;
  }
  if (UseSession3 && TimeLocal() >= s3start && TimeLocal() <= s3end)
  {
  comment = sess3comment;
  if (s3active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s3active = true;
  return(true);
  } 
  else
  {
  s3active = false;
  }
  
  if (UseSession3 && TimeLocal() >= s3start && TimeLocal() <= s3end)
  {
  comment = sess3comment;
  if (s3active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s3active = true;
  return(true);
  } 
  else
  {
  s3active = false;
  }

  if (UseSession4 && TimeLocal() >= s4start && TimeLocal() <= s4end)
  {
  comment = sess4comment;
  if (s4active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s4active = true;
  return(true);
  } 
  else
  {
  s4active = false;
  }

  if (UseSession5 && TimeLocal() >= s5start && TimeLocal() <= s5end)
  {
  comment = sess5comment;
  if (s5active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s5active = true;
  return(true);
  } 
  else
  {
  s5active = false;
  }
  
  if (UseSession6 && TimeLocal() >= s6start && TimeLocal() <= s6end)
  {
  comment = sess6comment;
  if (s6active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s6active = true;
  return(true);
  } 
  else
  {
  s6active = false;
  }
  //---
  return(false);
  }
void newSession()
  {
  profitbaskets = 0;
  lossbaskets = 0;
  SymbolMaxDD = 0.0;
  PercentMaxDDSymbol = 0.0;
  SymbolMaxHi=0.0;
  PercentFloatingSymbol = 0.0;
  currentlock = 0.0;
  trailstarted = false;   
  lockdistance = 0.0;
  }
//-----------------------------------------------------------------------------
void ChngBoxCol(int mVal, int mBx)
  {
  if(mVal >= 0 && mVal < 10)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, clrWhite);
  if(mVal > 10 && mVal < 20)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 20 && mVal < 30)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 30 && mVal < 40)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 40 && mVal < 50)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 50 && mVal < 60)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 60 && mVal < 70)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 70 && mVal < 80)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 80 && mVal < 90)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 90 && mVal < 100)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 100)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, clrSeaGreen);

  if(mVal < 0 && mVal > -10)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, clrWhite);
  if(mVal < -10 && mVal > -20)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -20 && mVal > -30)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -30 && mVal > -40)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -40 && mVal > -50)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -50 && mVal > -60)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -60 && mVal >-70)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -70 && mVal > -80)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -80 && mVal > -90)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -90)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
void ChngBoxCol1(int mVal1, int mBx1)
  {
  if(mVal1 >= 0 && mVal1 < 10)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, clrWhite);
  if(mVal1 > 10 && mVal1 < 20)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 20 && mVal1 < 30)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 30 && mVal1 < 40)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 40 && mVal1 < 50)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 50 && mVal1 < 60)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 60 && mVal1 < 70)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 70 && mVal1 < 80)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 80 && mVal1 < 90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 90 && mVal1 < 100)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 100)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);

  if(mVal1 < 0 && mVal1 > -10)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, clrWhite);
  if(mVal1 < -10 && mVal1 > -20)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -20 && mVal1 > -30)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -30 && mVal1 > -40)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -40 && mVal1 > -50)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -50 && mVal1 > -60)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -60 && mVal1 >-70)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -70 && mVal1 > -80)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -80 && mVal1 > -90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
void ChngBoxCol2(int mVal2, int mBx2)
  {
  if(mVal2 >= 0 && mVal2 < 10)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, clrWhite);
  if(mVal2 > 10 && mVal2 < 20)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 20 && mVal2 < 30)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 30 && mVal2 < 40)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 40 && mVal2 < 50)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 50 && mVal2 < 60)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 60 && mVal2 < 70)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 70 && mVal2 < 80)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 80 && mVal2 < 90)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 90 && mVal2 < 100)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 100)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);

  if(mVal2 < 0 && mVal2 > -10)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, clrWhite);
  if(mVal2 < -10 && mVal2 > -20)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -20 && mVal2 > -30)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -30 && mVal2 > -40)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -40 && mVal2 > -50)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -50 && mVal2 > -60)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -60 && mVal2 >-70)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -70 && mVal2 > -80)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -80 && mVal2 > -90)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -90)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
void ChngBoxCol3(int mVal3, int mBx3)
  {
  if(mVal3 >= 0 && mVal3 < 10)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, clrWhite);
  if(mVal3 > 10 && mVal3 < 20)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 20 && mVal3 < 30)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 30 && mVal3 < 40)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 40 && mVal3 < 50)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 50 && mVal3 < 60)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 60 && mVal3 < 70)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 70 && mVal3 < 80)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 80 && mVal3 < 90)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 90 && mVal3 < 100)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 100)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);

  if(mVal3 < 0 && mVal3 > -10)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, clrWhite);
  if(mVal3 < -10 && mVal3 > -20)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -20 && mVal3 > -30)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -30 && mVal3 > -40)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -40 && mVal3 > -50)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -50 && mVal3 > -60)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -60 && mVal3 >-70)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -70 && mVal3 > -80)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -80 && mVal3 > -90)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -90)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
void ChngBoxCol4(int mVal4, int mBx4)
  {
  if(mVal4 >= 0 && mVal4 < 10)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, clrWhite);
  if(mVal4 > 10 && mVal4 < 20)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 20 && mVal4 < 30)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 30 && mVal4 < 40)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 40 && mVal4 < 50)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 50 && mVal4 < 60)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 60 && mVal4 < 70)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 70 && mVal4 < 80)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 80 && mVal4 < 90)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 90 && mVal4 < 100)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 100)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);

  if(mVal4 < 0 && mVal4 > -10)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, clrWhite);
  if(mVal4 < -10 && mVal4 > -20)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -20 && mVal4 > -30)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -30 && mVal4 > -40)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -40 && mVal4 > -50)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -50 && mVal4 > -60)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -60 && mVal4 >-70)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -70 && mVal4 > -80)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -80 && mVal4 > -90)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -90)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//-----------------------------------------------------------------------------
bool InArray(string &pairs[], string symbol)
  {
  int arraysize = ArraySize(pairs);
  if(arraysize <= 0) return(false);
  if(symbol == NULL) return(false);
  int i;
  for(i=0;i<arraysize;i++)
  if(pairs[i] == symbol) return(true);
  return(false);
  }
//-------------------------------------------------------------------+ 
void PlotSpreadPips()
  {
  for (int i=0;i<ArraySize(DefaultPairs);i++)
  {
  if(MarketInfo(DefaultPairs[i],MODE_POINT) != 0 && pairinfo[i].pipsfactor != 0)
  {
  pairinfo[i].Pips = (iClose(DefaultPairs[i],PERIOD_CURRENT,0)-iOpen(DefaultPairs[i], PERIOD_CURRENT,0))/MarketInfo(DefaultPairs[i],MODE_POINT)/pairinfo[i].pipsfactor; 
  pairinfo[i].Pipsprev = (iClose(DefaultPairs[i],PERIOD_CURRENT,signals[i].shift+900)-iOpen(DefaultPairs[i], PERIOD_CURRENT,0))/MarketInfo(DefaultPairs[i],MODE_POINT)/pairinfo[i].pipsfactor;    
  pairinfo[i].Spread=MarketInfo(DefaultPairs[i],MODE_SPREAD)/pairinfo[i].pipsfactor;
  if(iClose(DefaultPairs[i], trigger_TF_HM5, 1)!=0)
  {
  signals[i].Signalperc = (iClose(DefaultPairs[i], 1, 0) - iClose(DefaultPairs[i], trigger_TF_HM1, 1)) / iClose(DefaultPairs[i], trigger_TF_HM1, 1) * 100;
  signals[i].Signalperc1 = (iClose(DefaultPairs[i], 1, 0) - iClose(DefaultPairs[i], trigger_TF_HM2, 1)) / iClose(DefaultPairs[i], trigger_TF_HM2, 1) * 100;    
  signals[i].Signalperc2 = (iClose(DefaultPairs[i], 1, 0) - iClose(DefaultPairs[i], trigger_TF_HM3, 1)) / iClose(DefaultPairs[i], trigger_TF_HM3, 1) * 100;
  signals[i].Signalperc3 = (iClose(DefaultPairs[i], 1, 0) - iClose(DefaultPairs[i], trigger_TF_HM4, 1)) / iClose(DefaultPairs[i], trigger_TF_HM4, 1) * 100;    
  signals[i].Signalperc4 = (iClose(DefaultPairs[i], 1, 0) - iClose(DefaultPairs[i], trigger_TF_HM5, 1)) / iClose(DefaultPairs[i], trigger_TF_HM5, 1) * 100;
  }    
  }  
  if(pairinfo[i].Pips>0){PipsColor =BullColor;
  }
  if(pairinfo[i].Pips<0){PipsColor =BearColor;
  } 
  if(pairinfo[i].Pips==0){PipsColor =clrWhite;
  }       
  if(pairinfo[i].Spread > MaxSpread)
  
  ObjectSetText("Spr1"+IntegerToString(i),DoubleToStr(pairinfo[i].Spread,1),8,NULL,Red);
  else
  ObjectSetText("Spr1"+IntegerToString(i),DoubleToStr(pairinfo[i].Spread,1),8,NULL,Orange);
  ObjectSetText("Pp1"+IntegerToString(i),DoubleToStr(MathAbs(pairinfo[i].Pips),0),8,NULL,PipsColor);
  
  if(pairinfo[i].Pips > pairinfo[i].Pipsprev)
  {
  pairinfo[i].PipsSig=UP;
  } 
  else
  {
  if(pairinfo[i].Pips < pairinfo[i].Pipsprev)
  pairinfo[i].PipsSig=DOWN;
  }  
  }
  }
//----------------------------------------------------------------------+
void GetAdrValues()
  {
  double s=0.0;
  for (int i=0;i<ArraySize(DefaultPairs);i++)
  {
  for(int a=1;a<=1;a++)
  {
  if(pairinfo[i].PairPip != 0)
  s=s+(iHigh(DefaultPairs[i],PERIOD_D1,a)-iLow(DefaultPairs[i],PERIOD_D1,a))/pairinfo[i].PairPip;
  if(a==1)
  adrvalues[i].adr1=MathRound(s);
  if(a==5)
  adrvalues[i].adr5=MathRound(s/5);
  if(a==10)
  adrvalues[i].adr10=MathRound(s/10);
  if(a==20)
  adrvalues[i].adr20=MathRound(s/20);
  }
  adrvalues[i].adr=MathRound((adrvalues[i].adr1+adrvalues[i].adr5+adrvalues[i].adr10+adrvalues[i].adr20)/4.0);
  s=0.0;
  }
  }
//-----------------------------------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------+ 
void GetSignals() 
  {
  // CANDLE DIRECTION
  //void GetSignals() {
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  { // for (int i=0;i<ArraySize(signals);i++) {
  double Openm1    = iOpen(DefaultPairs[i], PERIOD_M1,0);
  double Closem1   = iClose(DefaultPairs[i],PERIOD_M1,0);
  double Openm5    = iOpen(DefaultPairs[i], PERIOD_M5,0);
  double Closem5   = iClose(DefaultPairs[i],PERIOD_M5,0);
  double Openm15   = iOpen(DefaultPairs[i], PERIOD_M15,0);
  double Closem15  = iClose(DefaultPairs[i],PERIOD_M15,0);
  double Openm30   = iOpen(DefaultPairs[i], PERIOD_M30,0);
  double Closem30  = iClose(DefaultPairs[i],PERIOD_M30,0);
  double Openh1    = iOpen(DefaultPairs[i], PERIOD_H1,0);
  double Closeh1   = iClose(DefaultPairs[i],PERIOD_H1,0);      
  double Openh4    = iOpen(DefaultPairs[i], PERIOD_H4,0);
  double Closeh4   = iClose(DefaultPairs[i],PERIOD_H4,0);
  //double Opend     = iOpen(DefaultPairs[i], PERIOD_D1,0);
  //double Closed    = iClose(DefaultPairs[i],PERIOD_D1,0);
  //double Openw     = iOpen(DefaultPairs[i], PERIOD_W1,0);
  //double Closew    = iClose(DefaultPairs[i],PERIOD_W1,0);
  //double Openmn    = iOpen(DefaultPairs[i], PERIOD_MN1,0);
  //double Closemn   = iClose(DefaultPairs[i],PERIOD_MN1,0);
      
  if(Closem1>Openm1)signals[i].SignalCDm1=UP;
  if(Closem1<Openm1)signals[i].SignalCDm1=DOWN;
  if(Closem5>Openm5)signals[i].SignalCDm5=UP;
  if(Closem5<Openm5)signals[i].SignalCDm5=DOWN;
  if(Closem15>Openm15)signals[i].SignalCDm15=UP;
  if(Closem15<Openm15)signals[i].SignalCDm15=DOWN;
  if(Closem30>Openm30)signals[i].SignalCDm30=UP;
  if(Closem30<Openm30)signals[i].SignalCDm30=DOWN;
  if(Closeh1>Openh1)signals[i].SignalCDh1=UP;
  if(Closeh1<Openh1)signals[i].SignalCDh1=DOWN;
  if(Closeh4>Openh4)signals[i].SignalCDh4=UP;
  if(Closeh4<Openh4)signals[i].SignalCDh4=DOWN;
  //if(Closed>Opend)signals[i].Signald1=UP;
  //if(Closed<Opend)signals[i].Signald1=DOWN;
  //if(Closew>Openw)signals[i].Signalw1=UP;
  //if(Closew<Openw)signals[i].Signalw1=DOWN;
  //if(Closemn>Openmn)signals[i].Signalmn=UP;
  //if(Closemn<Openmn)signals[i].Signalmn=DOWN;
  signals[i].Signaldirup=signals[i].SignalCDm1==UP&&signals[i].SignalCDm5==UP&&signals[i].SignalCDm15==UP&&signals[i].SignalCDm30==UP&&signals[i].SignalCDh1==UP&&signals[i].SignalCDh4==UP/*&&signals[i].SignalCDd1==UP&&signals[i].SignalCDw1==UP&&signals[i].SignalCDmn==UP*/;
  signals[i].Signaldirdn=signals[i].SignalCDm1==DOWN&&signals[i].SignalCDm5==DOWN&&signals[i].SignalCDm15==DOWN&&signals[i].SignalCDm30==DOWN&&signals[i].SignalCDh1==DOWN&&signals[i].SignalCDh4==DOWN/*&&signals[i].SignalCDd1==DOWN&&signals[i].SignalCDw1==DOWN&&signals[i].SignalCDmn==DOWN*/;
  } 
  //void GetSignals()
  //  {
  int cnt = 0;
  ArrayResize(signals,ArraySize(DefaultPairs));
  for (int i=0;i<ArraySize(signals);i++)
  {
  signals[i].symbol=DefaultPairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,PERIOD_CURRENT,0);      
  signals[i].close=iClose(signals[i].symbol,PERIOD_CURRENT,0);
  signals[i].hi=MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-1800);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
  
  if(signals[i].range!=0)
  {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++)
  {
  if(signals[i].ratio <= 10.0) signals[i].fact = 0;
  if(signals[i].ratio >  10.0) signals[i].fact = 1;
  if(signals[i].ratio >  20.0) signals[i].fact = 2;
  if(signals[i].ratio >  30.0) signals[i].fact = 3;
  if(signals[i].ratio >  40.0) signals[i].fact = 4;
  if(signals[i].ratio >  50.0) signals[i].fact = 5;
  if(signals[i].ratio >  60.0) signals[i].fact = 6;
  if(signals[i].ratio >  70.0) signals[i].fact = 7;
  if(signals[i].ratio >  80.0) signals[i].fact = 8;
  if(signals[i].ratio >  90.0) signals[i].fact = 9;
  cnt++;

  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength=old_currency_strength(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  if(signals[i].ratio>signals[i].prevratio)
  {
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  if(signals[i].calc>=trigger_buy_relstrength)
  {
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  if(signals[i].strength5>=trigger_buy_buysellratio)
  {
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  if(signals[i].strength_Gap>=trigger_gap_buy)
  {
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  if(signals[i].strength5>signals[i].strength8)
  {
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }          
  }
  }
  }    
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+           
color Colorstr(double tot) 
  {
  if(tot>=trigger_buy_bidratio)
  return (BullColor);
  if(tot<=trigger_sell_bidratio)
  return (BearColor);
  return (clrWhite);
  }  
color ColorBSRat(double tot) 
  {
  if(tot>=trigger_buy_buysellratio)
  return (BullColor);
  if(tot<=trigger_sell_buysellratio)
  return (BearColor);
  return (clrWhite);
  } 
color ColorGap(double tot) 
  {
  if(tot>=trigger_gap_buy)
  return (BullColor);
  if(tot<=trigger_gap_sell)
  return (BearColor);
  return (clrWhite);
  }     
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+  
void displayMeter() 
  {
  double arrt[8][3];
  int arr2,arr3;
  arrt[0][0] = currency_strength(curr[0]);
  arrt[1][0] = currency_strength(curr[1]);
  arrt[2][0] = currency_strength(curr[2]);
  arrt[3][0] = currency_strength(curr[3]);
  arrt[4][0] = currency_strength(curr[4]);
  arrt[5][0] = currency_strength(curr[5]);
  arrt[6][0] = currency_strength(curr[6]);
  arrt[7][0] = currency_strength(curr[7]);
  arrt[0][2] = old_currency_strength(curr[7]);
  arrt[1][2] = old_currency_strength(curr[6]);
  arrt[2][2] = old_currency_strength(curr[5]);
  arrt[3][2] = old_currency_strength(curr[4]);
  arrt[4][2] = old_currency_strength(curr[3]);
  arrt[5][2] = old_currency_strength(curr[2]);
  arrt[6][2] = old_currency_strength(curr[1]);
  arrt[7][2] = old_currency_strength(curr[0]);
  arrt[0][1] = 7;
  arrt[1][1] = 6;
  arrt[2][1] = 5;
  arrt[3][1] = 4;
  arrt[4][1] = 3;
  arrt[5][1] = 2;
  arrt[6][1] = 1;
  arrt[7][1] = 0;
  ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
     
  for (int m = 0; m < 8; m++) 
  {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(curr[arr2]+"pos",IntegerToString(m+1)+".",x_axis+215,(m*15)+y_axis+535,color_for_profit(arrt[m][0]),8);
  SetText(curr[arr2]+"curr", curr[arr2],x_axis+230,(m*15)+y_axis+535,color_for_profit(arrt[m][0]),8);
  SetText(curr[arr2]+"currdig", DoubleToStr(arrt[m][0],1),x_axis+260,(m*15)+y_axis+535,color_for_profit(arrt[m][0]),8);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
  
  if(currstrength[m] > prevstrength[m]){SetObjText("Sdir"+IntegerToString(m),CharToStr(217),x_axis+282,(m*15)+y_axis+535,BullColor,8);
  }
  else if(currstrength[m] < prevstrength[m]){SetObjText("Sdir"+IntegerToString(m),CharToStr(218),x_axis+282,(m*15)+y_axis+535,BearColor,8);
  }
  else {SetObjText("Sdir"+IntegerToString(m),CharToStr(243),x_axis+282,(m*15)+y_axis+535,clrYellow,8);
  }
  }
ChartRedraw(); 
  }
//+------------------------------------------------------------------+
  color color_for_profit(double total) 
  {
  if(total<2.0)
  return (BearColor);
  if(total<=3.0)
  return (BearColor);
  if(total>7.0)
  return (BullColor);
  if(total>6.0)
  return (BullColor);
  if(total>5.0)
  return (BullColor);
  if(total<=4.0)
  return (BearColor);       
  return(clrWhite);
  }
  
  double currency_strength(string pair)
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
   for (int x = 0; x < ArraySize(DefaultPairs); x++) 
  {
  fact = 0;
  sym = DefaultPairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) 
  {
  // sym = sym + tempsym;
  range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - MarketInfo(sym, MODE_LOW)) / range );
  //if (ratio <=  0.0) fact = 0;
  if (ratio > 10.0) fact = 1;
  if (ratio > 20.0) fact = 2;
  if (ratio > 30.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 70.0) fact = 7;
  if (ratio > 80.0) fact = 8;
  if (ratio > 90.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;
  for(int x=0; x<ArraySize(DefaultPairs); x++) 
  {
  fact= 0;
  sym = DefaultPairs[x];
  int bar = iBarShift(DefaultPairs[x],PERIOD_M1,TimeCurrent()-1800);
  double prevbid = iClose(DefaultPairs[x],PERIOD_M1,bar);
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(MarketInfo(sym,MODE_HIGH)-MarketInfo(sym,MODE_LOW));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-MarketInfo(sym,MODE_LOW))/range);
  if(ratio > 10.0) fact = 1;
  if(ratio > 20.0) fact = 2;
  if(ratio > 30.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 70.0) fact = 7;
  if(ratio > 80.0) fact = 8;
  if(ratio > 90.0) fact = 9;
  cnt1++;
  if(pair==StringSubstr(sym,3,3))
  fact=9-fact;
  strength+=fact;
  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;
  return (strength);
  }
  
//-----------------------------------------------------------------------+
color Colorsync(double tot) 
  {
  if(tot>=trigger_buy_relstrength)
  return (BullColor);
  if(tot<=trigger_sell_relstrength)
  return (BearColor);
  return (clrWhite);
  } 
//-----------------------------------------------------------------------+
//+------------------------------------------------------------------+
void get_list_status(Pair &this_list[]) 
  {
  ArrayResize(this_list,ArraySize(DefaultPairs1));
  for(int i=0; i<ArraySize(this_list); i++)   
  {
  this_list[i].symbol1=DefaultPairs1[i];      
  this_list[i].point1=MarketInfo(this_list[i].symbol1,MODE_POINT);       
  this_list[i].open1=iOpen(this_list[i].symbol1,PERIOD_CURRENT,0);      
  this_list[i].close1=iClose(this_list[i].symbol1,PERIOD_CURRENT,0);
  this_list[i].hi1=MarketInfo(this_list[i].symbol1,MODE_HIGH);
  this_list[i].lo1=MarketInfo(this_list[i].symbol1,MODE_LOW);
  //this_list[i].range1=(this_list[i].hi1-signals[i].lo1);
  this_list[i].ask1=MarketInfo(this_list[i].symbol1,MODE_ASK);
  this_list[i].bid1=MarketInfo(this_list[i].symbol1,MODE_BID);
  
  
        
  if(this_list[i].point1==0.0001 || this_list[i].point1==0.01)
  this_list[i].pipsfactor1=1;
  if(this_list[i].point1==0.00001 || this_list[i].point1==0.001)
  this_list[i].pipsfactor1=10;
  if(this_list[i].point1 !=0 && this_list[i].pipsfactor1 != 0)
  { 
  this_list[i].spread1=MarketInfo(this_list[i].symbol1,MODE_SPREAD)/this_list[i].pipsfactor1;
  this_list[i].pips1=(this_list[i].close1-this_list[i].open1)/this_list[i].point1/this_list[i].pipsfactor1;
  } 
  if(this_list[i].open1>this_list[i].close1)
  {       
  this_list[i].range1=(this_list[i].hi1-this_list[i].lo1)*this_list[i].point1;      
  this_list[i].ratio1=MathMin((this_list[i].hi1-this_list[i].close1)/this_list[i].range1*this_list[i].point1/ (-0.01),100);
  this_list[i].calc1=this_list[i].ratio1/(-10);
  }
  else if(this_list[i].range1 !=0 )
  {
  this_list[i].range1=(this_list[i].hi1-this_list[i].lo1)*this_list[i].point1; 
  this_list[i].ratio1=MathMin(100*(this_list[i].close1-this_list[i].lo1)/this_list[i].range1*this_list[i].point1,100);
  this_list[i].calc1=this_list[i].ratio1/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list[j].ratio1<this_list[i].ratio1)
  swap(this_list[i],this_list[j]);
  } 
  else 
  {
  if(this_list[j].ratio1>this_list[i].ratio1)
  swap(this_list[i],this_list[j]);
  }
  }
  }   
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------+ 
void GetSignals1() 
  {
  ArrayResize(signals,ArraySize(DefaultPairs));
  for (int i=0;i<ArraySize(signals);
  i++) 
  {
  signals[i].symbol=DefaultPairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].digit1=MarketInfo(signals[i].symbol,MODE_DIGITS);
  signals[i].open=iOpen(signals[i].symbol,PERIOD_CURRENT,0);      
  signals[i].close=iClose(signals[i].symbol,PERIOD_CURRENT,0);
  signals[i].high1=MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].low1=MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid1=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].ask1=MarketInfo(signals[i].symbol,MODE_ASK);
  if((signals[i].high1-signals[i].low1) !=0)
  {
  signals[i].bidratio1=((signals[i].bid1-signals[i].low1)/(signals[i].high1-signals[i].low1)*100);
  signals[i].range2=((signals[i].high1-signals[i].low1)/signals[i].point/pairinfo[i].pipsfactor);      
  signals[i].ratio1=MathMin((signals[i].high1-signals[i].close)/signals[i].range2*signals[i].point / (-0.01),100);
  }            
  }  
  } 
//+------------------------------------------------------------------+ 
   
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
color ColorPips1(double Pips) 
  {
  if(Pips>0)
  return (BullColor);
  if(Pips<0)
  return (BearColor);
  return (clrWhite);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
color Colorstr1(double tot) 
  {
  if(tot>=trigger_buy_bidratio1)
  return (BullColor);
  if(tot<=trigger_sell_bidratio1)
  return (BearColor);
  return (clrWhite);
  }
//-------------------------------------------------------------------+
//-------------------------------------------------------------------+
void swap (Pair &i, Pair &j) 
  {
  string strTemp;
  double dblTemp;
  int    intTemp;
   
  strTemp = i.symbol1; i.symbol1 = j.symbol1; j.symbol1 = strTemp;
  dblTemp = i.point1; i.point1 = j.point1; j.point1 = dblTemp;               
  dblTemp = i.open1; i.open1 = j.open1; j.open1 = dblTemp;
  dblTemp = i.close1; i.close1 = j.close1; j.close1 = dblTemp;               
  dblTemp = i.hi1; i.hi1 = j.hi1; j.hi1 = dblTemp;          
  dblTemp = i.lo1; i.lo1 = j.lo1; j.lo1 = dblTemp;               
  dblTemp = i.ask1; i.ask1 = j.ask1; j.ask1 = dblTemp;               
  dblTemp = i.bid1; i.bid1 = j.bid1; j.bid1 = dblTemp;               
  intTemp = i.pipsfactor1; i.pipsfactor1 = j.pipsfactor1; j.pipsfactor1 = intTemp;               
  dblTemp = i.spread1; i.spread1 = j.spread1; j.spread1 = dblTemp;      
  dblTemp = i.pips1; i.pips1 = j.pips1; j.pips1 = dblTemp;  
  dblTemp = i.range1; i.range1 = j.range1; j.range1 = dblTemp;  
  dblTemp = i.ratio1; i.ratio1 = j.ratio1; j.ratio1 = dblTemp;  
  dblTemp = i.calc1; i.calc1= j.calc1; j.calc1 = dblTemp;  
  
  }

//display 2
//+------------------------------------------------------------------+ 
void displayMeter1() 
  {
  double arrt1[8][2];
  int arr21;
  arrt1[0][0] = currency_strength(curr1[0]);
  arrt1[1][0] = currency_strength(curr1[1]);
  arrt1[2][0] = currency_strength(curr1[2]);
  arrt1[3][0] = currency_strength(curr1[3]);
  arrt1[4][0] = currency_strength(curr1[4]);
  arrt1[5][0] = currency_strength(curr1[5]);
  arrt1[6][0] = currency_strength(curr1[6]);
  arrt1[7][0] = currency_strength(curr1[7]);
  arrt1[0][1] = 0;
  arrt1[1][1] = 1;
  arrt1[2][1] = 2;
  arrt1[3][1] = 3;
  arrt1[4][1] = 4;
  arrt1[5][1] = 5;
  arrt1[6][1] = 6;
  arrt1[7][1] = 7;
  ArraySort(arrt1, WHOLE_ARRAY, 0, MODE_DESCEND);
     
  for (int m = 0; 
  m < 8; m++) 
  {
  arr21 = arrt1[m][1];
  SetText(curr1[arr21]+"pos2",IntegerToString(m+1)+".",x_axis+215,(m*15)+y_axis+234,color_for_profit1(arrt1[m][0]),8);
  SetText(curr1[arr21]+"curr2", curr1[arr21],x_axis+230,(m*15)+y_axis+234,color_for_profit1(arrt1[m][0]),8);
  SetText(curr1[arr21]+"currdig2", DoubleToStr(arrt1[m][0],2),x_axis+260,(m*15)+y_axis+234,color_for_profit1(arrt1[m][0]),8);
 
  //if(currstrength[m] > prevstrength[m]){SetObjText("Sdir2"+IntegerToString(m),CharToStr(217),x_axis+282,(m*15)+y_axis+234,clrDodgerBlue,8);
  //}
  //else if(currstrength[m] < prevstrength[m]){SetObjText("Sdir2"+IntegerToString(m),CharToStr(218),x_axis+282,(m*15)+y_axis+234,clrFireBrick,8);
  //}
  //else {SetObjText("Sdir2"+IntegerToString(m),CharToStr(243),x_axis+282,(m*15)+y_axis+234,clrWhite,8);
  //}
  }
 ChartRedraw(); 
  }

//display 2
color color_for_profit1(double total) 
  {
/*  if(total<=2.0)
  return (BearColor);   
  if(total>=7.0)   
  return (BullColor);
  if(total>=5.0)   
  return (BullColor);
  if(total<=3.0)   
  return (BearColor);
  return(BullColor);*/

  if(total<2.0)
  return (BearColor);
  if(total<=3.0)
  return (BearColor);
  if(total>7.0)
  return (BullColor);
  if(total>6.0)
  return (BullColor);
  if(total>5.0)
  return (BullColor);
  if(total<=4.0)
  return (BearColor);       
  return(clrWhite);
  }
double currency_strength1(string pair) 
  {
  int fact1;
  string sym1;
  double range1;
  double ratio1;
  double strength11 = 0;
  int cnt11 = 0;
  //for (int x = 0; x < ArraySize(Defaultpairs); x++) {
  fact1 = 0;
  //sym1 = Defaultpairs[x];
  if (pair == StringSubstr(sym1, 0, 3) || pair == StringSubstr(sym1, 3, 3)) 
  {
  sym1 = sym1 + tempsym1;
  range1 = (MarketInfo(sym1, MODE_HIGH) - MarketInfo(sym1, MODE_LOW)) * MarketInfo(sym1, MODE_POINT);
  if (range1 != 0.0) 
  {
  ratio1 = 100.0 * ((MarketInfo(sym1, MODE_BID) - MarketInfo(sym1, MODE_LOW)) / range1 * MarketInfo(sym1, MODE_POINT));
  if (ratio1 > 10.0) fact1 = 1;
  if (ratio1 > 20.0) fact1 = 2;
  if (ratio1 > 30.0) fact1 = 3;
  if (ratio1 > 40.0) fact1 = 4;
  if (ratio1 > 50.0) fact1 = 5;
  if (ratio1 > 60.0) fact1 = 6;
  if (ratio1 > 70.0) fact1 = 7;
  if (ratio1 > 80.0) fact1 = 8;
  if (ratio1 > 90.0) fact1 = 9;
  cnt11++;
  if (pair == StringSubstr(sym1, 3, 3)) fact1 = 9 - fact1;
  strength11 += fact1;
  }
  }      
  //}
  if(cnt11!=0)strength11 /= cnt11;
  return (strength11);
  }
 
//------------------------------------------------------------------------
//-----------------------------------------------------------------------------------+
/*double old_currency_strength1(string pair) 
  {
  int fact1;
  string sym1;
  double range1;
  double ratio1;
  double strength11=0;
  int cnt11=0;
  
  for(int x=0; x<ArraySize(DefaultPairs1); 
  x++) 
  {
  fact1= 0;
  sym1 = DefaultPairs1[x];
  int bar1 = iBarShift(DefaultPairs1[x],PERIOD_H4,TimeCurrent()-1800);
  double prevbid1 = iClose(DefaultPairs1[x],PERIOD_H4,bar1);
  
  if(pair==StringSubstr(sym1,0,3) || pair==StringSubstr(sym1,3,3)) 
  {
  // sym = sym + tempsym;
  range1=(MarketInfo(sym1,MODE_HIGH)-MarketInfo(sym1,MODE_LOW));
  if(range1!=0.0) 
  {
  ratio1=100.0 *((prevbid1-MarketInfo(sym1,MODE_LOW))/range1);
  
  if(ratio1 > 10.0)  fact1 = 1;
  if(ratio1 > 20.0) fact1 = 2;
  if(ratio1 > 30.0) fact1 = 3;
  if(ratio1 > 40.0) fact1 = 4;
  if(ratio1 > 50.0) fact1 = 5;
  if(ratio1 > 60.0) fact1 = 6;
  if(ratio1 > 70.0) fact1 = 7;
  if(ratio1 > 80.0) fact1 = 8;
  if(ratio1 > 90.0) fact1 = 9;
  
  cnt11++;
  if(pair==StringSubstr(sym1,3,3))
  fact1=9-fact1;
  strength11+=fact1;
  }
  }
  }
  if(cnt11!=0)
  strength11/=cnt11;
  return (strength11);
} */
//-----------------------------------------------------------------------+

//-----------------------------------------------------------------------+
color Colorsync1(double tot) 
  {
  if(tot>=trigger_buy_relstrength1)
  return (BullColor);
  if(tot<=trigger_sell_relstrength1)
  return (BearColor);
  return (clrWhite);
  }
//-----------------------------------------------------------------------+
//-----------------------------------------------------------------------+
/*color ColorsyncMM(double tot) 
  {
  if(tot>=trigger_buy_relstrength1)
  return (clrDodgerBlue);
  if(tot<=trigger_sell_relstrength1)
  return (clrFireBrick);
  return (clrWhite);
  }*/
//-----------------------------------------------------------------------+
//======================RUN=974===============01 
void GetCommodity() 
  {
  for (int i=0;i<ArraySize(DefaultPairs);i++) {
  signals[i].Signalcci = NONE;
  double cci = iCCI(DefaultPairs[i],0, trade_Period_CCI1, PRICE_OPEN, PERIOD_M1);
  double CloseBuy1_1 =  cci ;
  double CloseBuy1_21 = -0;
  double CloseSell1_1 =  cci ;
  double CloseSell1_21 = 0;   
  if (CloseBuy1_1 < CloseBuy1_21)  
  {        
  signals[i].Signalcciup1 = UP;
  } 
  if (CloseSell1_1 > CloseSell1_21) 
  {        
  signals[i].Signalccidn1 = DOWN;
  } 
//======================RUN=974===============02 
//void GetCommodity2() {
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  signals[i].Signalcci = NONE;
  double cci = iCCI(DefaultPairs[i],0, trade_Period_CCI2, PRICE_OPEN, PERIOD_M5);
  double CloseBuy1_1 =  cci ;
  double CloseBuy1_22 = -0;
  double CloseSell1_1 =  cci ;
  double CloseSell1_22 = 0;   
  if (CloseBuy1_1 < CloseBuy1_22)  
  {        
  signals[i].Signalcciup2 = UP;
  } 
  if (CloseSell1_1 > CloseSell1_22) 
  {        
  signals[i].Signalccidn2 = DOWN;
  }      
//======================RUN=974===============03 
//void GetCommodity3() {
  for (int i=0;i<ArraySize(DefaultPairs);i++)
  {
  signals[i].Signalcci = NONE;
  double cci = iCCI(DefaultPairs[i],0, trade_Period_CCI3, PRICE_OPEN, PERIOD_M15);
  double CloseBuy1_1 =  cci ;
  double CloseBuy1_23 = -0;
  double CloseSell1_1 =  cci ;
  double CloseSell1_23 = 0;   
  if (CloseBuy1_1 < CloseBuy1_23)  
  {        
  signals[i].Signalcciup3 = UP;
  } 
  if (CloseSell1_1 > CloseSell1_23) 
  {        
  signals[i].Signalccidn3 = DOWN;
  }      
  }
  }   
//======================RUN=974===============   
//MACD
//int OnInit(void)
  {
  IndicatorDigits(Digits+1);
//--- drawing settings
  SetIndexStyle(0,DRAW_HISTOGRAM);
  SetIndexStyle(1,DRAW_LINE);
  SetIndexDrawBegin(1,SignPeriod);
//--- indicator buffers mapping
  SetIndexBuffer(0,ExtMacdBuffer);
  SetIndexBuffer(1,ExtSignalBuffer);
//--- name for DataWindow and indicator subwindow label
  IndicatorShortName("MACD("+IntegerToString(FastPeriod)+","+IntegerToString(SlowPeriod)+","+IntegerToString(SignPeriod)+")");
  SetIndexLabel(0,"MACD");
  SetIndexLabel(1,"Signal");
//--- check for input parameters
  if(FastPeriod<=1 || SlowPeriod<=1 || SignPeriod<=1 || FastPeriod>=SlowPeriod)
  {
  Print("Wrong input parameters");
  ExtParameters=false;
//return(INIT_FAILED);
  }
  else
  ExtParameters=true;
//--- initialization done
//return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
/*int OnCalculate (const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])
  {
  int i,limit;
//---
  if(rates_total<=InpSignalSMA || !ExtParameters)
  return(0);
//--- last counted bar will be recounted
  limit=rates_total-prev_calculated;
  if(prev_calculated>0)
  //limit++;
//--- macd counted in the 1-st buffer
  for(i=0; i<limit; i++)
  ExtMacdBuffer[i]=iMA(NULL,0,InpFastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
  iMA(NULL,0,InpSlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//--- signal line counted in the 2-nd buffer
  SimpleMAOnBuffer(rates_total,prev_calculated,0,InpSignalSMA,ExtMacdBuffer,ExtSignalBuffer);
//--- done
  return(rates_total);
  }*/
//MACD
  double valuem = iMACD(DefaultPairs[i],PERIOD_M1,FastPeriod,SlowPeriod,SignPeriod,Price,MODE_MAIN  ,0); //Times[t] no lugar no period
  double values = iMACD(DefaultPairs[i],PERIOD_M1,FastPeriod,SlowPeriod,SignPeriod,Price,MODE_SIGNAL,0);
  if (valuem > 0)
  if (valuem > values) 
  signals[i].SignalMACDup01=UP;
  if (valuem < 0)
  if (valuem < values) 
  signals[i].SignalMACDdn01=DOWN; 
  /*signals[i].SignalMACDup=(signals[i].Signalham12==UP&&signals[i].Signalham52==UP);
  signals[i].SignalMACDdn=(signals[i].Signalham12==DOWN&&signals[i].Signalham52==DOWN);*/               
//MACD
//MACD1
//int OnInit(void)
  {
  IndicatorDigits(Digits+1);
//--- drawing settings
  SetIndexStyle(0,DRAW_HISTOGRAM);
  SetIndexStyle(1,DRAW_LINE);
  SetIndexDrawBegin(1,SignPeriod1);
//--- indicator buffers mapping
  SetIndexBuffer(0,ExtMacdBuffer1);
  SetIndexBuffer(1,ExtSignalBuffer1);
//--- name for DataWindow and indicator subwindow label
  IndicatorShortName("MACD("+IntegerToString(FastPeriod1)+","+IntegerToString(SlowPeriod1)+","+IntegerToString(SignPeriod1)+")");
  SetIndexLabel(0,"MACD");
  SetIndexLabel(1,"Signal");
//--- check for input parameters
  if(FastPeriod1<=1 || SlowPeriod1<=1 || SignPeriod1<=1 || FastPeriod1>=SlowPeriod1)
  {
  Print("Wrong input parameters");
  ExtParameters1=false;
  //return(INIT_FAILED);
  }
  else
  ExtParameters1=true;
//--- initialization done
  //return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
/*int OnCalculate (const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])
  {
  int i,limit;
//---
  if(rates_total<=InpSignalSMA || !ExtParameters)
  return(0);
//--- last counted bar will be recounted
  limit=rates_total-prev_calculated;
  if(prev_calculated>0)
  //limit++;
//--- macd counted in the 1-st buffer
  for(i=0; i<limit; i++)
  ExtMacdBuffer[i]=iMA(NULL,0,InpFastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
  iMA(NULL,0,InpSlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//--- signal line counted in the 2-nd buffer
  SimpleMAOnBuffer(rates_total,prev_calculated,0,InpSignalSMA,ExtMacdBuffer,ExtSignalBuffer);
//--- done
  return(rates_total);
  }*/
//MACD
  double valuem1 = iMACD(DefaultPairs[i],PERIOD_M5,FastPeriod1,SlowPeriod1,SignPeriod1,Price,MODE_MAIN  ,0); //Times[t] no lugar no period
  double values1 = iMACD(DefaultPairs[i],PERIOD_M5,FastPeriod1,SlowPeriod1,SignPeriod1,Price,MODE_SIGNAL,0);
  if (valuem1 > 0)
  if (valuem1 > values1) 
  signals[i].SignalMACDup02=UP;
  if (valuem1 < 0)
  if (valuem1 < values1) 
  signals[i].SignalMACDdn02=DOWN; 
  /*signals[i].SignalMACDup=(signals[i].Signalham12==UP&&signals[i].Signalham52==UP);
  signals[i].SignalMACDdn=(signals[i].Signalham12==DOWN&&signals[i].Signalham52==DOWN);*/               
//MACD
//MACD2
//int OnInit(void)
  {
  IndicatorDigits(Digits+1);
//--- drawing settings
  SetIndexStyle(0,DRAW_HISTOGRAM);
  SetIndexStyle(1,DRAW_LINE);
  SetIndexDrawBegin(1,SignPeriod2);
//--- indicator buffers mapping
  SetIndexBuffer(0,ExtMacdBuffer2);
  SetIndexBuffer(1,ExtSignalBuffer2);
//--- name for DataWindow and indicator subwindow label
  IndicatorShortName("MACD("+IntegerToString(FastPeriod2)+","+IntegerToString(SlowPeriod2)+","+IntegerToString(SignPeriod2)+")");
  SetIndexLabel(0,"MACD");
  SetIndexLabel(1,"Signal");
//--- check for input parameters
  if(FastPeriod2<=1 || SlowPeriod2<=1 || SignPeriod2<=1 || FastPeriod2>=SlowPeriod2)
  {
  Print("Wrong input parameters");
  ExtParameters2=false;
  //return(INIT_FAILED);
  }
  else
  ExtParameters2=true;
//--- initialization done
  //return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
/*int OnCalculate (const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])
  {
  int i,limit;
//---
  if(rates_total<=InpSignalSMA || !ExtParameters)
  return(0);
//--- last counted bar will be recounted
  limit=rates_total-prev_calculated;
  if(prev_calculated>0)
  //limit++;
//--- macd counted in the 1-st buffer
  for(i=0; i<limit; i++)
  ExtMacdBuffer[i]=iMA(NULL,0,InpFastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
  iMA(NULL,0,InpSlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//--- signal line counted in the 2-nd buffer
  SimpleMAOnBuffer(rates_total,prev_calculated,0,InpSignalSMA,ExtMacdBuffer,ExtSignalBuffer);
//--- done
  return(rates_total);
  }*/
//MACD
  double valuem2 = iMACD(DefaultPairs[i],PERIOD_M15,FastPeriod2,SlowPeriod2,SignPeriod2,Price,MODE_MAIN  ,0); //Times[t] no lugar no period
  double values2 = iMACD(DefaultPairs[i],PERIOD_M15,FastPeriod2,SlowPeriod2,SignPeriod2,Price,MODE_SIGNAL,0);
  if (valuem2 > 0)
  if (valuem2 > values2) 
  signals[i].SignalMACDup03=UP;
  if (valuem2 < 0)
  if (valuem2 < values2) 
  signals[i].SignalMACDdn03=DOWN; 
  
  /*signals[i].SignalMACDup=(signals[i].Signalham12==UP&&signals[i].Signalham52==UP);
  signals[i].SignalMACDdn=(signals[i].Signalham12==DOWN&&signals[i].Signalham52==DOWN);*/               
//MACD
//+------------------------------------------------------------------+
  for (int i=0;i<ArraySize(DefaultPairs);i++)
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average1,0,MODE_EMA,PRICE_OPEN,0);//MM12 //PERIODO TIME FRAME ALTERAR DE PERIOD_M1 PARA NULL OU TF     
  double BB10 = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average1,0,MODE_EMA,PRICE_OPEN,0);//MM12       
  
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB1 )
  signals[i].SignalM01up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB1 )
  signals[i].SignalM01up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB10 )
  signals[i].SignalM02dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB10 )
  signals[i].SignalM02dn=DOWN;
  signals[i].Signalmaup10=(signals[i].SignalM01up==UP&&signals[i].SignalM02dn==UP);
  signals[i].Signalmadn10=(signals[i].SignalM01up==DOWN&&signals[i].SignalM02dn==DOWN); 
  /*if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB1 )
  list[i].calc1=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB1 )
  list[i].calc1=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB10 )
  list[i].calc1=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB10 )
  list[i].calc1=DOWN;
  signals[i].Signalmaup10=(list[i].calc1==UP&&list[i].calc1==UP);
  signals[i].Signalmadn10=(list[i].calc1==DOWN&&list[i].calc1==DOWN);*/   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  }
  else
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA41
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average2,0,MODE_EMA,PRICE_OPEN,0);//MM12      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average2,0,MODE_EMA,PRICE_OPEN,0);//MM12       
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB1 )
  signals[i].SignalM03up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB1 )
  signals[i].SignalM03up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB10 )
  signals[i].SignalM04dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB10 )
  signals[i].SignalM04dn=DOWN;
  signals[i].Signalmaup11=(signals[i].SignalM03up==UP&&signals[i].SignalM04dn==UP);
  signals[i].Signalmadn11=(signals[i].SignalM03up==DOWN&&signals[i].SignalM04dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM4 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM4 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM4 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM4 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  }
  else
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA42
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average3,0,MODE_EMA,PRICE_OPEN,0);//MM12      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average3,0,MODE_EMA,PRICE_OPEN,0);//MM12       
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB1 )
  signals[i].SignalM05up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB1 )
  signals[i].SignalM05up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB10 )
  signals[i].SignalM06dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB10 )
  signals[i].SignalM06dn=DOWN;
  signals[i].Signalmaup12=(signals[i].SignalM05up==UP&&signals[i].SignalM06dn==UP);
  signals[i].Signalmadn12=(signals[i].SignalM05up==DOWN&&signals[i].SignalM06dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM5 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM5 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM5 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM5 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0)
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA5
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average4,0,MODE_EMA,PRICE_OPEN,0);//MM21      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average4,0,MODE_EMA,PRICE_OPEN,0);//MM21       
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB1 )
  signals[i].SignalM07up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB1 )
  signals[i].SignalM07up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB10 )
  signals[i].SignalM08dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB10 )
  signals[i].SignalM08dn=DOWN;
  signals[i].Signalmaup13=(signals[i].SignalM07up==UP&&signals[i].SignalM08dn==UP);
  signals[i].Signalmadn13=(signals[i].SignalM07up==DOWN&&signals[i].SignalM08dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA51
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average5,0,MODE_EMA,PRICE_OPEN,0);//MM21      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average5,0,MODE_EMA,PRICE_OPEN,0);//MM21       
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB1 )
  signals[i].SignalM09up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB1 )
  signals[i].SignalM09up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB10 )
  signals[i].SignalM10dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB10 )
  signals[i].SignalM10dn=DOWN;
  signals[i].Signalmaup14=(signals[i].SignalM09up==UP&&signals[i].SignalM10dn==UP);
  signals[i].Signalmadn14=(signals[i].SignalM09up==DOWN&&signals[i].SignalM10dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM4 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM4 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM4 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM4 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA52
  for (int i=0;i<ArraySize(DefaultPairs);i++)
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average6,0,MODE_EMA,PRICE_OPEN,0);//MM21      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average6,0,MODE_EMA,PRICE_OPEN,0);//MM21       
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB1 )
  signals[i].SignalM11up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB1 )
  signals[i].SignalM11up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB10 )
  signals[i].SignalM12dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB10 )
  signals[i].SignalM12dn=DOWN;
  signals[i].Signalmaup15=(signals[i].SignalM11up==UP&&signals[i].SignalM12dn==UP);
  signals[i].Signalmadn15=(signals[i].SignalM11up==DOWN&&signals[i].SignalM12dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM5 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM5 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM5 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM5 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA1
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average7,0,MODE_EMA,PRICE_OPEN,0);//MM30      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average7,0,MODE_EMA,PRICE_OPEN,0);//MM30       
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB1 )
  signals[i].SignalM13up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB1 )
  signals[i].SignalM13up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB10 )
  signals[i].SignalM14dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB10 )
  signals[i].SignalM14dn=DOWN;
  signals[i].Signalmaup1=(signals[i].SignalM13up==UP&&signals[i].SignalM14dn==UP);
  signals[i].Signalmadn1=(signals[i].SignalM13up==DOWN&&signals[i].SignalM14dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  } //tirar uma chave para fechar codigo
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA11
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average8,0,MODE_EMA,PRICE_OPEN,0);//MM30      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average8,0,MODE_EMA,PRICE_OPEN,0);//MM30       
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB1 )
  signals[i].SignalM15up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB1 )
  signals[i].SignalM15up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB10 )
  signals[i].SignalM16dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB10 )
  signals[i].SignalM16dn=DOWN;
  signals[i].Signalmaup2=(signals[i].SignalM15up==UP&&signals[i].SignalM16dn==UP);
  signals[i].Signalmadn2=(signals[i].SignalM15up==DOWN&&signals[i].SignalM16dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM4 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM4 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM4 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM4 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  } //tirar uma chave para fechar codigo
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA12
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average9,0,MODE_EMA,PRICE_OPEN,0);//MM30      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average9,0,MODE_EMA,PRICE_OPEN,0);//MM30       
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB1 )
  signals[i].SignalM17up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB1 )
  signals[i].SignalM17up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB10 )
  signals[i].SignalM18dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB10 )
  signals[i].SignalM18dn=DOWN;
  signals[i].Signalmaup3=(signals[i].SignalM17up==UP&&signals[i].SignalM18dn==UP);
  signals[i].Signalmadn3=(signals[i].SignalM17up==DOWN&&signals[i].SignalM18dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM5 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM5 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM5 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM5 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  } //tirar uma chave para fechar codigo
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA2
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average10,0,MODE_EMA,PRICE_OPEN,0);//MM50      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average10,0,MODE_EMA,PRICE_OPEN,0);//MM50       
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB1 )
  signals[i].SignalM19up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB1 )
  signals[i].SignalM19up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB10 )
  signals[i].SignalM20dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB10 )
  signals[i].SignalM20dn=DOWN;
  signals[i].Signalmaup4=(signals[i].SignalM19up==UP&&signals[i].SignalM20dn==UP);
  signals[i].Signalmadn4=(signals[i].SignalM19up==DOWN&&signals[i].SignalM20dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  } //tirar uma chave para fechar codigo
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA22
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average11,0,MODE_EMA,PRICE_OPEN,0);//MM50      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average11,0,MODE_EMA,PRICE_OPEN,0);//MM50       
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB1 )
  signals[i].SignalM21up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB1 )
  signals[i].SignalM21up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB10 )
  signals[i].SignalM22dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB10 )
  signals[i].SignalM22dn=DOWN;
  signals[i].Signalmaup5=(signals[i].SignalM21up==UP&&signals[i].SignalM22dn==UP);
  signals[i].Signalmadn5=(signals[i].SignalM21up==DOWN&&signals[i].SignalM22dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM4 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM4 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM4 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM4 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  } //tirar uma chave para fechar codigo
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA23
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average12,0,MODE_EMA,PRICE_OPEN,0);//MM50      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average12,0,MODE_EMA,PRICE_OPEN,0);//MM50       
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB1 )
  signals[i].SignalM23up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB1 )
  signals[i].SignalM23up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB10 )
  signals[i].SignalM24dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB10 )
  signals[i].SignalM24dn=DOWN;
  signals[i].Signalmaup6=(signals[i].SignalM23up==UP&&signals[i].SignalM24dn==UP);
  signals[i].Signalmadn6=(signals[i].SignalM23up==DOWN&&signals[i].SignalM24dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM5 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM5 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM5 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM5 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  } //tirar uma chave para fechar codigo
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA3
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average13,0,MODE_EMA,PRICE_OPEN,0);//MM100      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M1,trade_Period_Moving_Average13,0,MODE_EMA,PRICE_OPEN,0);//MM100       
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB1 )
  signals[i].SignalM25up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB1 )
  signals[i].SignalM25up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)>BB10 )
  signals[i].SignalM26dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M1,0)<BB10 )
  signals[i].SignalM26dn=DOWN;
  signals[i].Signalmaup7=(signals[i].SignalM25up==UP&&signals[i].SignalM26dn==UP);
  signals[i].Signalmadn7=(signals[i].SignalM25up==DOWN&&signals[i].SignalM26dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA31
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average14,0,MODE_EMA,PRICE_OPEN,0);//MM100      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M5,trade_Period_Moving_Average14,0,MODE_EMA,PRICE_OPEN,0);//MM100       
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB1 )
  signals[i].SignalM27up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB1 )
  signals[i].SignalM27up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)>BB10 )
  signals[i].SignalM28dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M5,0)<BB10 )
  signals[i].SignalM28dn=DOWN;
  signals[i].Signalmaup8=(signals[i].SignalM27up==UP&&signals[i].SignalM28dn==UP);
  signals[i].Signalmadn8=(signals[i].SignalM27up==DOWN&&signals[i].SignalM28dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM4 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM4 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM4 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM4 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVMA32
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  double BB1  = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average15,0,MODE_EMA,PRICE_OPEN,0);//MM100      
  double BB10 = iMA(DefaultPairs[i],PERIOD_M15,trade_Period_Moving_Average15,0,MODE_EMA,PRICE_OPEN,0);//MM100       
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB1 )
  signals[i].SignalM29up=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB1 )
  signals[i].SignalM29up=DOWN;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)>BB10 )
  signals[i].SignalM30dn=UP;
  if(iClose(DefaultPairs[i],PERIOD_M15,0)<BB10 )
  signals[i].SignalM30dn=DOWN;
  signals[i].Signalmaup9=(signals[i].SignalM29up==UP&&signals[i].SignalM30dn==UP);
  signals[i].Signalmadn9=(signals[i].SignalM29up==DOWN&&signals[i].SignalM30dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(DefaultPairs[i],trigger_TF_HM5 ,0);
  double low    = iLow(DefaultPairs[i],trigger_TF_HM5 ,0);
  double close  = iClose(DefaultPairs[i],trigger_TF_HM5 ,0);
  double open   = iOpen(DefaultPairs[i],trigger_TF_HM5 ,0);
  double point  = MarketInfo(DefaultPairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
//     }
//   }
//  }
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVRSI02
  double Openlast = iRSI(DefaultPairs[i],PERIOD_M1,trade_Period_RSI1,0,1);
  double Openbefore = iRSI(DefaultPairs[i],PERIOD_M1,trade_Period_RSI1,0,0);
  if (Openlast<Openbefore && Openlast>30) 
  {
  signals[i].Signalrsidn1 = DOWN;
  }
  if (Openlast>Openbefore && Openlast<70)  
  {
  signals[i].Signalrsiup1 = UP;
  }   
  }
  }
void GetCommodity1() 
  {
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  signals[i].Signalrsi = NONE; 
  //  }//}
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVRSI03
  double Openlast = iRSI(DefaultPairs[i],PERIOD_M5,trade_Period_RSI2,0,0);
  double Openbefore = iRSI(DefaultPairs[i],PERIOD_M5,trade_Period_RSI2,0,1);
  if (Openlast<Openbefore && Openlast>30) 
  {
  signals[i].Signalrsidn2 = DOWN;
  }
  if (Openlast>Openbefore && Openlast<70)  
  {
  signals[i].Signalrsiup2 = UP;
  }   
  }
  }
void GetCommodity2() 
  {
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  signals[i].Signalrsi = NONE; 
  //  }//}
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVRSI01
  double Openlast = iRSI(DefaultPairs[i],PERIOD_M15,trade_Period_RSI3,0,0);
  double Openbefore = iRSI(DefaultPairs[i],PERIOD_M15,trade_Period_RSI3,0,1);
  if (Openlast<Openbefore && Openlast>30) 
  {
  signals[i].Signalrsidn3 = DOWN;
  }
  if (Openlast>Openbefore && Openlast<70)  
  {
  signals[i].Signalrsiup3 = UP;
  }   
  }
  }
void GetCommodity3()
  {
  for (int i=0;i<ArraySize(DefaultPairs);i++) 
  {
  signals[i].Signalrsi = NONE; 
  }
  }
//VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVRSI
//INFO ACCOUNT
 bool    ShowProfitInfo          = False;
 bool    ShowTodayRanges         = False;
 bool    ShowRiskInfo            = False;
 bool    ShowAccountOrderInfo    = true;
input int     RiskStopLoss            = 5;
input string  RiskLevels              = "1,5,10,20,40,50,60,80,100";

 bool    OnlyAttachedSymbol      = False;
 int     MagicNumber             = -1;
 string  CommentFilter           = "";
input string  StartDateFilter         = "2022.12.06"; //aaaa-mm-dd
//input int     FontSize                = 8;
 bool    WhiteMode               = False;

int      windowIndex                   = 0;
string   preCurrSign                   = "";
string   postCurrSign                  = "";
double   pip_multiplier                = 1.0;
int      daySeconds                    = 86400;

double   MaxDD            = 0,
         MaxDDp           = 0,
         CurrentDD        = 0, 
         CurrentDDp       = 0;

datetime maxDDDay;
datetime startDateFilter = 0;
datetime LastDrawProfitInfo = 0;

//string   IndiName                      = "InfoTrade v1.0";

/*******************  Version history  ********************************
   
 
***********************************************************************/

//+------------------------------------------------------------------+
/*int init() 
{
//+------------------------------------------------------------------+
	//IndicatorShortName(IndiName);
   DeleteAllObject();

   SetPipMultiplier(Symbol());

   setCurrency();
   
   // Load today max DD from global
   maxDDDay     = getGlobalVar("TRADEINFO_DD_DAY", 0);
   if (maxDDDay >= iTime(Symbol(), PERIOD_D1, 0))
   {
      MaxDD    = getGlobalVar("TRADEINFO_MAXDD", 0);
      MaxDDp   = getGlobalVar("TRADEINFO_MAXDDP", 0);
   } else {
   
      maxDDDay = iTime(Symbol(), PERIOD_D1, 0);
      MaxDD    = 0;
      MaxDDp   = 0;      
   }
   
   if (StartDateFilter != "")
      startDateFilter = StrToTime(StartDateFilter);

   
   return(0);
}
*/
//+------------------------------------------------------------------+
int start() 
{
//+------------------------------------------------------------------+
   DoWork(); 

   return(0); 
}

//+------------------------------------------------------------------+
void DoWork() {
//+------------------------------------------------------------------+
//   windowIndex = WindowFind(IndiName);

   CalculateDailyDrawDown();

   if (ShowAccountOrderInfo) DrawAccountInfo();
   if (ShowAccountOrderInfo) DrawCurrentTrades();  
   if (ShowTodayRanges) DrawTodayRange();
   if (ShowProfitInfo) DrawProfitHistory();
   if (ShowRiskInfo) DrawRiskInfo(); 
   //DrawCopyright();
}

//+------------------------------------------------------------------+
//int deinit() {
//+------------------------------------------------------------------+
//   DeleteAllObject();

//  return(0);
//}

//+------------------------------------------------------------------+
void CalculateDailyDrawDown() {
//+------------------------------------------------------------------+
   double balance = AccountBalance();

   if (balance != 0)
   {
      CurrentDD = 0.0 - ( AccountMargin() + (AccountBalance() - AccountEquity()));
      CurrentDDp = MathDiv(CurrentDD, balance) * 100.0;

      if (CurrentDD < MaxDD || iTime(Symbol(), PERIOD_D1, 0) > maxDDDay)
      {
         MaxDD    = CurrentDD;
         MaxDDp   = CurrentDDp;
         maxDDDay = iTime(Symbol(), PERIOD_D1, 0);
         
         // Save to Global
         setGlobalVar("TRADEINFO_MAXDD",  MaxDD);
         setGlobalVar("TRADEINFO_MAXDDP", MaxDDp);
         setGlobalVar("TRADEINFO_DD_DAY", maxDDDay);
      }

   }
}

//+------------------------------------------------------------------+
double ND(double value, int decimal = -1) { 
//+------------------------------------------------------------------+
   if (decimal == -1)
      decimal = Digits();
   
   return (NormalizeDouble(value, decimal)); 
}

//+------------------------------------------------------------------+
string CutAt(string& str, string sep) {
//+------------------------------------------------------------------+
   string res = "";
   
   int index = StringFind(str, sep, 0);
   if (index != -1)
   {
      if (index > 0) res = StringSubstr(str, 0, index);
      str = StringSubstr(str, index + StringLen(sep));    
   } else {
      res = str;
      str = "";
   }
   return(res);
}

//+------------------------------------------------------------------+
color levelColors[10] = {Lime, SpringGreen, SpringGreen, LawnGreen, Gold, Gold, DarkSalmon, Tomato, Tomato, FireBrick};
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void DrawRiskInfo() {
//+------------------------------------------------------------------+
   SetPipMultiplier(Symbol());

   if (RiskStopLoss > 0)
      DrawText(1, 0, 300, "Risco Ordem (SL=" + RiskStopLoss + ")", WhiteMode?Black:White, FontSize=8); 
   else
      DrawText(1, 0, 300, "Risco Ordem", WhiteMode?Black:White, FontSize=8); 
   
//   DrawText(1, 1, 0, "-------------------", WhiteMode?Black:White, FontSize=8); 
   
   string levels = RiskLevels;
   int i = 0;
  
   while (StringLen(levels) > 0)
   {
      string c = StringTrimLeft(StringTrimRight(CutAt(levels, ",")));
      double value = StringToDouble(c);
      
      if (value != EMPTY_VALUE) {
      
         color clr = levelColors[ArraySize(levelColors) - 1];
         if ( i < ArraySize(levelColors))
            clr = levelColors[i];            
      
         DrawText(1, i + 2, 320, StringConcatenate(value, "%:   ", DTS(MM(value), 2) + " lot"), clr, FontSize=8); 
         i++;
         
      }
   } 
}

//+------------------------------------------------------------------+
void DrawAccountInfo() {
//+------------------------------------------------------------------+
   SetPipMultiplier(Symbol());

   int row = 1;
   string text;
   int colWidth1 = 180;
   color c = WhiteMode?DarkBlue:LightCyan;
   text = StringConcatenate("Saldo:  ", MTS(AccountBalance())); 
   DrawText(0, row, 0, text, c, FontSize =8); 
   
   double eqPercent = 0;
   if (AccountBalance() > 0)
      eqPercent = MathDiv(AccountEquity(), AccountBalance() * 100.0);
   
   text = StringConcatenate("Equity:  ", MTS(AccountEquity()), "  (", DTS(eqPercent, 2), "%)"); 
   DrawText(0, row, colWidth1, text, c, FontSize); 
   row++;
   double marginLevel = 0;
   
   if (AccountMargin() > 0) marginLevel = MathDiv(AccountEquity(), AccountMargin() * 100.0);
   text = StringConcatenate("Margem: ", DTS(AccountMargin(), 2), "  (", DTS(marginLevel, 2), "%)"); 
   DrawText(0, row, 0, text, c, FontSize); 
   
   if (AccountFreeMargin() < 0)
      c = Red;
   text = StringConcatenate("Margem Livre: ", DTS(AccountFreeMargin(), 2)); 
   DrawText(0, row, colWidth1, text, c, FontSize); 
   row++;
   c = WhiteMode?DarkBlue:LightCyan;

   text = StringConcatenate("Alavancagem: 1:", AccountLeverage()); 
   DrawText(0, row, 0, text, c, FontSize); 
   
   text = StringConcatenate("Swap  Compra: ", MTS(MarketInfo(Symbol(), MODE_SWAPLONG), 2), "  Venda: ", MTS(MarketInfo(Symbol(), MODE_SWAPSHORT), 2)); 
   DrawText(0, row, colWidth1, text, c, FontSize); 
   row++;

//   DrawText(0, row, 0, "------------------------------------------------------------------", Gray, FontSize); 
}

//+------------------------------------------------------------------+
bool IsValidOrder() {
//+------------------------------------------------------------------+
   if (!OnlyAttachedSymbol || OrderSymbol() == Symbol()) 
      if ( MagicNumber == -1 || MagicNumber == OrderMagicNumber() )
         if (CommentFilter == "" || StringFind(OrderComment(), CommentFilter) != -1)
            return(true);

   return(false);
}

//+------------------------------------------------------------------+
void DrawCurrentTrades() {
//+------------------------------------------------------------------+
   int buyCount, sellCount = 0;
   double buyProfit, sellProfit, buyLot, sellLot, buyPip, sellPip = 0;
   double slPip, tpPip;
   double allTPPips, allSLPips = 0;
   double maxLoss, maxProfit = 0;
   color c = White;
   string text = "";
   int colWidth1 = 200;

   for (int i = OrdersTotal() - 1; i >= 0; i--)
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         if ( IsValidOrder() )
         {
            slPip = 0;
            tpPip = 0;
            if (OrderType() == OP_BUY) {
               buyCount++;
               buyProfit += OrderProfit() + OrderSwap() + OrderCommission();
               buyLot += OrderLots();
               buyPip += point2pip(MarketInfo(OrderSymbol(), MODE_BID) - OrderOpenPrice(), OrderSymbol());

               if (OrderStopLoss() > 0.0) slPip = point2pip(OrderOpenPrice() - OrderStopLoss(), OrderSymbol());
               if (OrderTakeProfit() > 0.0) tpPip = point2pip(OrderTakeProfit() - OrderOpenPrice(), OrderSymbol());
                  
            } else if (OrderType() == OP_SELL) {
               sellCount++;
               sellProfit += OrderProfit() + OrderSwap() + OrderCommission();
               sellLot += OrderLots();
               sellPip += point2pip(OrderOpenPrice() - MarketInfo(OrderSymbol(), MODE_BID), OrderSymbol());

               if (OrderStopLoss() > 0.0) slPip = point2pip(OrderStopLoss() - OrderOpenPrice(), OrderSymbol());
               if (OrderTakeProfit() > 0.0) tpPip = point2pip(OrderOpenPrice() - OrderTakeProfit(), OrderSymbol());
            }         
            if (slPip != 0) {
               maxLoss -= pip2money(slPip, OrderLots(), OrderSymbol());
               allSLPips -= slPip;
            }
            
            if (tpPip != 0) {
               maxProfit += pip2money(tpPip, OrderLots(), OrderSymbol()) + OrderSwap() + OrderCommission();
               allTPPips += tpPip;
            }
            
         }

   SetPipMultiplier(Symbol());

   int row = 5;

   //Spread   
   double spread = MathDiv(MarketInfo(Symbol(), MODE_SPREAD), pip_multiplier);
   if (spread < 3) c = WhiteMode?DarkGreen:LawnGreen; else c = Crimson;   
   text = StringConcatenate("Spread: ", DTS(spread, 2)); 
   DrawText(0, row=5, 0, text, c, FontSize=8); 

   //Drawdown
   if (CurrentDD < 0) c = WhiteMode?Red:LightPink; else if (CurrentDD == 0.0) c = WhiteMode?Black:White; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("DD Corrente: ", DTS(CurrentDD, 2), "   (" + DTS(CurrentDDp, 2), "%)"); 
   DrawText(0, row, colWidth1=180, text, c, FontSize=8); 
   row++;

   //Max daily Drawdown
   if (MaxDD < 0) c = WhiteMode?Red:LightPink; else if (MaxDD == 0.0) c = WhiteMode?Black:White; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("DD Max. Diário: ", DTS(MaxDD, 2), "   (" + DTS(MaxDDp, 2), "%)"); 
   DrawText(0, row, colWidth1, text, c, FontSize=8); 
   row++;


   //Max loss + profit
   if (maxProfit < 0) c = FireBrick; else if (maxProfit > 0) c = WhiteMode?DarkGreen:LawnGreen; else c = WhiteMode?Black:White;
   text = StringConcatenate("Est. profit: ", MTS(maxProfit), "  (", DTS(allTPPips, 1), " pips)"); 
   DrawText(0, row, 0, text, c, FontSize=8); 

   if (maxLoss < 0) c = Red; else if (maxLoss > 0) c = WhiteMode?DarkGreen:LawnGreen; else c = WhiteMode?Black:White;
   double maxLossp = 0; if (AccountBalance() > 0) maxLossp = MathDiv(maxLoss, AccountBalance() * 100);
   text = StringConcatenate("Max loss:  ", MTS(maxLoss), "  (", DTS(allSLPips, 1), " pips)  (", DTS(maxLossp, 2), "%)"); 
   DrawText(0, row, colWidth1, text, c, FontSize=8); 
   row++;
   
//   DrawText(0, row, 0, "------------------------------------------------------------------", Gray, FontSize); 
   row++;

   //Order counts
   c = WhiteMode?DimGray:Gainsboro;
   text = StringConcatenate("Buy:    ", buyCount); 
   DrawText(0, row, 0, text, c, FontSize=8); 
   text = StringConcatenate("Sell:    ", sellCount); 
   DrawText(0, row + 1, 0, text, c, FontSize=8);  

//   DrawText(0, row + 2, 0, "------------------------------------------------------------------", Gray, FontSize); 
   text = StringConcatenate("Total:  ", buyCount + sellCount); 
   DrawText(0, row + 3, 0, text, c, FontSize=8); 

   // Order lots
   text = StringConcatenate("Lot: ", DTS(buyLot, 2)); 
   DrawText(0, row, 65, text, c, FontSize=8); 
   text = StringConcatenate("Lot: ", DTS(sellLot, 2)); 
   DrawText(0, row + 1, 65, text, c, FontSize=8); 
   text = StringConcatenate("Lot: ", DTS(buyLot + sellLot, 2)); 
   DrawText(0, row + 3, 65, text, c, FontSize=8); 
   
   // Order profits
   if (buyProfit < 0) c = Crimson; else if (buyProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(buyProfit), "   (", DTS(buyPip, 1), " pips)"); 
   DrawText(0, row, colWidth1, text, c, FontSize=8); 


   if (sellProfit < 0) c = Crimson; else if (sellProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(sellProfit), "   (", DTS(sellPip, 1), " pips)"); 
   DrawText(0, row + 1, colWidth1, text, c, FontSize=8); 

   if (buyProfit + sellProfit < 0) c = Crimson; else if (buyProfit + sellProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(buyProfit + sellProfit), "   (", DTS(buyPip + sellPip, 1), " pips)"); 
   DrawText(0, row + 3, colWidth1, text, c, FontSize=8); 
}

//+------------------------------------------------------------------+
void DrawProfitHistory() {
//+------------------------------------------------------------------+
   if (LastDrawProfitInfo > TimeCurrent() - 10) return;
   LastDrawProfitInfo = TimeCurrent();

   datetime day, today, now, prevDay;
   
   int xOffset = 350;
   if (!ShowRiskInfo) xOffset = 5;

   DrawText(1, 0, xOffset + 275, "DATE", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 230, "PIPS", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 180, "PROFIT", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 130, "GAIN %", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 100 , "LOT", Gray, FontSize=8); 
//   DrawText(1, 1, xOffset     , "====================================", Gray, FontSize=8); 

   now = TimeCurrent();
   today = StrToTime(TimeToStr(now, TIME_DATE));

   DrawDayHistoryLine(xOffset, today, now, 2, "Today");

   day = today; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 3, "Yesterday");

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 4);

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 5);

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 6);
   
   day = DateOfMonday();
   DrawDayHistoryLine(xOffset, day, now, 7, "Week");

   day = StrToTime(Year()+"."+Month()+".01");
   DrawDayHistoryLine(xOffset, day, now, 8, "Month");

   day = StrToTime(Year()+".01.01");
   DrawDayHistoryLine(xOffset, day, now, 9, "Year");
   
//   DrawText(1, 10, xOffset, "====================================", Gray, FontSize=8); 

   // Daily & Monthly profit
   if (AccountBalance() != 0.0)
   {
      double pips, profit, lots = 0;
      datetime firstOrderTime = GetHistoryInfoFromDate(day, now, pips, profit, lots);
      if (now - firstOrderTime != 0)
      {
         int oneDay = 86400; //int oneMonth = oneDay * 30.4;
         double daily   = MathDiv(MathDiv(profit, MathDiv(now - firstOrderTime, oneDay)), (AccountBalance() - profit)) * 100.0;
         double monthly = daily * 30.4;

         DrawText(1, 11, xOffset = 430, StringConcatenate("Monthly: ", DTS(monthly, 2), "%"), ColorOnSign(monthly), FontSize=8); 
         DrawText(1, 11, xOffset + 150, StringConcatenate("Daily: ", DTS(daily, 2), "%"), ColorOnSign(daily), FontSize=8); 
      }
   }

//   DrawText(1, 12, xOffset = 360, "====================================", Gray, FontSize=8); 
}

//+------------------------------------------------------------------+
double MathDiv(double a, double b) {
//+------------------------------------------------------------------+
   if (b != 0.0)
      return(a/b);

   return(0.0);
}  

//+------------------------------------------------------------------+
void DrawDayHistoryLine(int xOffset, datetime prevDay, datetime day, int row, string header = "") {
//+------------------------------------------------------------------+
   if (header == "") header = TimeToStr(prevDay, TIME_DATE); 

   double pips, profit, percent, lots = 0.0;
   string text;
   
   GetHistoryInfoFromDate(prevDay, day, pips, profit, lots);
   double profitp = 0;
   if (AccountBalance() > 0) profitp = MathDiv(profit, (AccountBalance() - profit)) * 100.0;
   
   text = StringConcatenate(header, ": "); 
   DrawText(1, row, xOffset + 270, text, WhiteMode?DimGray:Gray, FontSize=8); 

   text = DTS(pips, 1); 
   DrawText(1, row, xOffset + 240, text, ColorOnSign(pips), FontSize=8); 

   text = MTS(profit); 
   DrawText(1, row, xOffset + 195, text, ColorOnSign(profit), FontSize=8); 

   text = StringConcatenate(DTS(profitp, 2), "%"); 
   DrawText(1, row, xOffset + 140, text, ColorOnSign(profitp), FontSize=8); 

   text = DTS(lots, 2); 
   DrawText(1, row, xOffset + 95, text, ColorOnSign(profit), FontSize=8); 
}

//+------------------------------------------------------------------+
void DrawTodayRange() {
//+------------------------------------------------------------------+
   string text;
   
   SetPipMultiplier(Symbol());
   
   double todayPips = point2pip(iHigh(NULL, PERIOD_H1, 0) - iLow(NULL, PERIOD_H1, 0));
   double yesterdayPips = point2pip(iHigh(NULL, PERIOD_H1, 1) - iLow(NULL, PERIOD_H1, 1));

   double thisWeekPips = point2pip(iHigh(NULL, PERIOD_H4, 0) - iLow(NULL, PERIOD_H4, 0));
   double lastWeekPips = point2pip(iHigh(NULL, PERIOD_H4, 1) - iLow(NULL, PERIOD_H4, 1));

   double thisMonthPips = point2pip(iHigh(NULL, PERIOD_D1, 0) - iLow(NULL, PERIOD_D1, 0));
   double lastMonthPips = point2pip(iHigh(NULL, PERIOD_D1, 1) - iLow(NULL, PERIOD_D1, 1));
   
   int colWidth2 = 430;
   int colWidth3 = 540;
   int row = 1;
   color c = C'141,176,241';
   DrawText(0, row, colWidth2, "Today range:", c, FontSize);                  DrawText(0, row, colWidth3, StringConcatenate(DTS(todayPips, 1), " pips"), c, FontSize); 
   DrawText(0, row + 1, colWidth2, "Yesterday range:", c, FontSize);          DrawText(0, row + 1, colWidth3, StringConcatenate(DTS(yesterdayPips, 1), " pips"), c, FontSize); 
   row += 3;
   
   c = C'103,150,237';
   DrawText(0, row, colWidth2, "This week range:", c, FontSize);              DrawText(0, row, colWidth3, StringConcatenate(DTS(thisWeekPips, 1), " pips"), c, FontSize); 
   DrawText(0, row + 1, colWidth2, "Last week range:", c, FontSize);          DrawText(0, row + 1, colWidth3, StringConcatenate(DTS(lastWeekPips, 1), " pips"), c, FontSize); 
   row += 3;

   c = C'65,123,233';
   DrawText(0, row, colWidth2, "This month range:", c, FontSize);             DrawText(0, row, colWidth3, StringConcatenate(DTS(thisMonthPips, 1), " pips"), c, FontSize); 
   DrawText(0, row + 1, colWidth2, "Last month range:", c, FontSize);         DrawText(0, row + 1, colWidth3, StringConcatenate(DTS(lastMonthPips, 1), " pips"), c, FontSize); 
   row += 3;


   datetime nextCandleTime = (Period() * 1440) - (TimeCurrent() - iTime(NULL, 0, 0));

   c = WhiteMode?Orange:Bisque;
   DrawText(0, row, colWidth2, "Novo Dia:", c, FontSize=8);                  DrawText(0, row, colWidth3, TimeToStr(nextCandleTime, TIME_SECONDS), c, FontSize=8); 
}

//+------------------------------------------------------------------+
//void DrawCopyright() {
//+------------------------------------------------------------------+
//   string text = StringConcatenate(IndiName, " - Created by Samurai FX - fb.com/FenixCapital.Ltda"); 
//   DrawText(3, 0, 0, text, DimGray, 7);
//}

//+------------------------------------------------------------------+
datetime GetHistoryInfoFromDate(datetime prevDay, datetime day, double &pips, double &profit, double &lots) {
//+------------------------------------------------------------------+
   datetime res = day;
   int i, k = OrdersHistoryTotal();
   pips = 0;
   profit = 0;
   lots = 0;
  
   for (i = 0; i < k; i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) {
         if ( IsValidOrder() ) {
           if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
               if (day >= OrderCloseTime() && OrderCloseTime() >= prevDay && OrderCloseTime() > startDateFilter) {
                  profit += OrderProfit() + OrderCommission() + OrderSwap();

                  if (OrderType() == OP_BUY) {
                     pips += point2pip(OrderClosePrice() - OrderOpenPrice(), OrderSymbol());
                  }
                  if (OrderType() == OP_SELL) {
                     pips += point2pip(OrderOpenPrice() - OrderClosePrice(), OrderSymbol());
                  }                  
                  lots += OrderLots();
                  
                  if (OrderCloseTime() < res) res = OrderCloseTime();
               }
            }
         }
      }
   }
   return(res);
}

//+------------------------------------------------------------------+
datetime GetPreviousDay(datetime curDay) {
//+------------------------------------------------------------------+
   datetime prevDay = curDay;
   
   while (TimeDayOfWeek(prevDay) < 1 || TimeDayOfWeek(prevDay) > 5) prevDay -= daySeconds;
   return(prevDay);
}

//+------------------------------------------------------------------+
datetime DateOfMonday(int no = 0) {
//+------------------------------------------------------------------+
  datetime dt = StrToTime(TimeToStr(TimeCurrent(), TIME_DATE));

  while (TimeDayOfWeek(dt) != 1) dt -= daySeconds;
  dt += no * 7 * daySeconds;

  return(dt);
}

color ColorOnSign(double value) {
  color lcColor = WhiteMode?DimGray:Gray;

  if (value > 0) lcColor = WhiteMode?DarkGreen:Green;
  if (value < 0) lcColor = FireBrick;

  return(lcColor);
}

//+------------------------------------------------------------------+
double MM(double Risk) {
//+------------------------------------------------------------------+
   double SL = RiskStopLoss;
   double NewLOT = 0;

   string Symb = Symbol();                                                    // Symb default value
   double One_Lot = MarketInfo(Symb,MODE_MARGINREQUIRED);                     // margin for 1 LOT
   double Min_Lot = MarketInfo(Symb,MODE_MINLOT);                             // Minimum LOT
   double Max_Lot = MarketInfo(Symb,MODE_MAXLOT);                             // Maximum LOT
   double Step   = MarketInfo(Symb,MODE_LOTSTEP);                             // Lot step
   double Free   = AccountFreeMargin();                                       // Free margin
//-------------------------------------------------------------------------------
   if (SL > 0)                                                                // If set StopLoss
   {               
      double RiskAmount = AccountEquity() * (Risk / 100);                     // Calc risk in money
      double tickValue = MarketInfo(Symb, MODE_TICKVALUE) * pip_multiplier;   // Get how many pips 1 unit price
      
      if (tickValue * SL != 0) NewLOT = RiskAmount / (tickValue * SL);        // Divide Risk price with SL price
      if (Step > 0) NewLOT = MathFloor(NewLOT / Step) * Step; //Round         // Round LOT to step
   }
//-------------------------------------------------------------------------------
   else                                                                       // Dynamic LOT calculation
   {                                                        
      if (Risk > 100)                                                         // If greater then 100
         Risk = 100;                                                          // then 100%
      if (Risk == 0)                                                          // If 0
         NewLOT = Min_Lot;                                                    // then minimal LOT
      else                                                                    
         if (Step > 0 && One_Lot > 0) 
            NewLOT = MathFloor(Free * Risk / 100 / One_Lot / Step) * Step;    // Calc by Risk and round to step
   }
//-------------------------------------------------------------------------------
   if (NewLOT < Min_Lot)                                                      // If smaller than minimum
      NewLOT = Min_Lot;                                                       // set to minimum LOT
   if (NewLOT > Max_Lot)                                                      // If greater than maximum
      NewLOT = Max_Lot;                                                       // set to maximum LOT
//-------------------------------------------------------------------------------
   double margin = NewLOT * One_Lot;                                          // Calc the required margin for LOT
   if (margin > AccountFreeMargin())                                          // If greater than the free
   {                                                                          // Message, alert, ...etczenet, alert....stb.       
      //string msg = "You have not enough money! Free margin: " + DTS(AccountFreeMargin(), 2) + ", Require: " + DTS(margin, 2); 
      //Log.Warning(msg);
      //Print(msg);
      //Alert(msg);
      return(0);                                                              // Return with 0. Skip the order open
   }
   return(NewLOT);                            
}

//+------------------------------------------------------------------+
void setCurrency() {
//+------------------------------------------------------------------+
   string currSign = AccountCurrency();
   if (currSign == "USD") {
      preCurrSign = "$";
      postCurrSign = postCurrSign;   
   } else if (currSign == "EUR") {
      preCurrSign = "";
      postCurrSign = postCurrSign;   
   } else {
      preCurrSign = "";
      postCurrSign = postCurrSign;   
   }
}

//+------------------------------------------------------------------+
string MTS(double value, int decimal = 2) {
//+------------------------------------------------------------------+
   return(StringConcatenate(preCurrSign, DTS(value, decimal), postCurrSign));
}

//+------------------------------------------------------------------+
string DTS(double value, int decimal = 0) { return(DoubleToStr(value, decimal)); }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
double point2pip(double point, string Symb = "") {
//+------------------------------------------------------------------+
   if (Symb == "") Symb = Symbol();

   SetPipMultiplier(Symb);
   
   return(MathDiv(MathDiv(point, MarketInfo(Symb, MODE_POINT)), pip_multiplier));
}

//+------------------------------------------------------------------+
double pip2money(double pip, double lot, string Symb) {
//+------------------------------------------------------------------+
   if (Symb == "") Symb = Symbol();

   SetPipMultiplier(Symb);

   double tickSize = MarketInfo(Symb, MODE_TICKSIZE);
   if (tickSize != 0)
   {
      double onePipValue = MarketInfo(Symb, MODE_TICKVALUE) * (MarketInfo(Symb, MODE_POINT) / tickSize);
      return((pip * pip_multiplier) * onePipValue * lot);
   } else return(0);
}

//+------------------------------------------------------------------+
double SetPipMultiplier(string Symb, bool simple = false) {
//+------------------------------------------------------------------+
   pip_multiplier = 1;
   int digit = MarketInfo(Symb, MODE_DIGITS);
   
   if (simple)
   {
      if (digit % 4 != 0) pip_multiplier = 10; 
        
   } else {
      if (digit == 5 || 
         (digit == 3 && StringFind(Symb, "JPY") > -1) ||     // If 3 digits and currency is JPY
         (digit == 2 && StringFind(Symb, "XAU") > -1) ||     // If 2 digits and currency is gold
         (digit == 2 && StringFind(Symb, "GOLD") > -1) ||    // If 2 digits and currency is gold
         (digit == 3 && StringFind(Symb, "XAG") > -1) ||     // If 3 digits and currency is silver
         (digit == 3 && StringFind(Symb, "SILVER") > -1) ||  // If 3 digits and currency is silver
         (digit == 1))                                       // If 1 digit (CFDs)
            pip_multiplier = 10;
      else if (digit == 6 || 
         (digit == 4 && StringFind(Symb, "JPY") > -1) ||     // If 4 digits and currency is JPY
         (digit == 3 && StringFind(Symb, "XAU") > -1) ||     // If 3 digits and currency is gold
         (digit == 3 && StringFind(Symb, "GOLD") > -1) ||    // If 3 digits and currency is gold
         (digit == 4 && StringFind(Symb, "XAG") > -1) ||     // If 4 digits and currency is silver
         (digit == 4 && StringFind(Symb, "SILVER") > -1) ||  // If 4 digits and currency is silver
         (digit == 2))                                       // If 2 digit (CFDs)
            pip_multiplier = 100;
   }  
   //Print("PipMultiplier: ", pip_multiplier, ", Digits: ", Digits);
   return(pip_multiplier);
}

//+------------------------------------------------------------------+
void DrawText(int corner, int row, int xOffset, string text, color c, int size = 7) {
//+------------------------------------------------------------------+
   string objName = "TradeInfo_" + DTS(corner) + "_" + DTS(xOffset) + "_" + DTS(row);
   if (ObjectFind(objName) != 0) {
      ObjectCreate(objName, OBJ_LABEL, windowIndex, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, corner);
      ObjectSet(objName, OBJPROP_SELECTABLE, 0);
      ObjectSet(objName, OBJPROP_HIDDEN, 1);
   }

   ObjectSetText(objName, text, size, "Verdana", c);
   ObjectSet(objName, OBJPROP_XDISTANCE, 6 + xOffset);
   ObjectSet(objName, OBJPROP_YDISTANCE, 6 + row * (size + 6));
   ObjectSet(objName, OBJPROP_BACK, false);
}

//+------------------------------------------------------------------+
double getGlobalVar(string name, double defaultValue = EMPTY_VALUE) {
//+------------------------------------------------------------------+
   if (GlobalVariableCheck(name))
      return (GlobalVariableGet(name));
   else 
      return (defaultValue);
}

//+------------------------------------------------------------------+
string setGlobalVar(string name, double value = EMPTY_VALUE) {
//+------------------------------------------------------------------+
   if (value == EMPTY_VALUE)
      GlobalVariableDel(name);
   else  
      GlobalVariableSet(name, value);
      
   return(name);
}

//+------------------------------------------------------------------+
void DeleteAllObject() {
//+------------------------------------------------------------------+
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
      if(StringFind(ObjectName(i), "TradeInfo_", 0) >= 0)
         ObjectDelete(ObjectName(i));

}
//---

//FX MULTI-METER 2





