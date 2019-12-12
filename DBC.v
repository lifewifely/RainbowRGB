module DBC
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