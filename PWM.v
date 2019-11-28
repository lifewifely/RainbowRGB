module PWM
(input CLK
,input FLAG
,input BP
,output STT
,output PWM
);

reg[24:0]cnt1;//Max=33554431
reg[24:0]cnt2;
reg stt;

reg[24:0]FREQ=25'd1500;
reg[1:0]f;
always@(posedge BP)
	f<=f+1'b1;
always@(posedge CLK)
	case(f)
		2'b00:FREQ<=25'd1500;
		2'b01:FREQ<=25'd3000;
		2'b10:FREQ<=25'd4500;
		default:FREQ<=25'd6000;
	endcase

always@(posedge CLK)
	if(cnt1>=FREQ-1'b1)
		cnt1<=1'b0;
	else
		cnt1<=cnt1+1'b1;

always@(posedge CLK)
	if(cnt2==FREQ-1'b1)
		stt<=1'b1;
	else
		stt<=1'b0;

always@(posedge CLK)
	if(cnt1==FREQ-1'b1)
		if(FLAG)
			if(cnt2>=FREQ-1'b1)
				cnt2<=1'b0;
			else
				cnt2<=cnt2+1'b1;
		else if(!FLAG)
			if(cnt2<=0)
				cnt2<=FREQ-1'b1;
			else
				cnt2<=cnt2-1'b1;
	else
		cnt2<=cnt2;

assign PWM=(cnt1<cnt2)?1'b1:1'b0;//核心
assign STT=stt;

endmodule