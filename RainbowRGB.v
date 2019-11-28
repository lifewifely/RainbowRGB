/*
实现彩虹效果呼吸灯,
用按键控制呼吸频率,
单灯或双灯同步等功能.
*/
module RainbowRGB
(input CLK
,input BTN
,output[2:0]LED
);

wire BP;
Debounce UUD4(CLK,BTN,BP);

reg[23:0]freq;
wire DW;
wire UP;
wire STT1;
wire STT2;//占位
wire STT3;//占位
PWM UUD1(CLK,1,BP,STT1,DW);
PWM UUD2(CLK,0,BP,STT2,UP);

reg[1:0]flag1=2'b00;
reg[1:0]flag2=2'b01;
reg[1:0]flag3=2'b10;
always@(posedge STT1)
	if(flag1==2'b10)
		flag1<=2'b00;
	else
		flag1<=flag1+1'b1;
always@(posedge STT1)
	if(flag2==2'b10)
		flag2<=2'b00;
	else
		flag2<=flag2+1'b1;
always@(posedge STT1)
	if(flag3==2'b10)
		flag3<=2'b00;
	else
		flag3<=flag3+1'b1;

assign LED[0]=(flag1==2'b00)?UP:((flag1==2'b01)?DW:1'b1);
//assign LED[1]=(flag2==2'b00)?DW:((flag2==2'b01)?UP:1'b1);
//assign LED[2]=(flag3==2'b00)?DW:((flag3==2'b01)?UP:1'b1);
//assign LED[0]=UP;
assign LED[1]=1'b1;
assign LED[2]=1'b1;

endmodule

module Debounce
(input CLK
,input KEY//待消抖按键
,output KP//消抖后的按键脉冲
);

reg[18:0]cnt_h;//高电平计数器
reg[18:0]cnt_l;//低电平计数器
reg kp;

always @(posedge CLK)//按键为低电平时,开始计数
	if(!KEY)
		cnt_l<=cnt_l+1'b1;
	else
		cnt_l<=0;

always@(posedge CLK)//按键为高电平时,开始计数
	if(KEY)
		cnt_h<=cnt_h+1'b1;
	else
		cnt_h<= 0;

always@(posedge CLK)//计数器积攒到10ms发出按键脉冲
	if(cnt_h==19'h7a120)
		kp<=1;
	else if(cnt_l==19'h7a120)
		kp<=0;
	else
		kp<=kp;

assign KP=kp;

endmodule