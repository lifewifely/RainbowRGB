module RainbowRGB
(input CLK
,input BTN
,output[7:0]LED
,output[2:0]RGB
);

wire BP;

DBC i0(CLK,BTN,BP);

reg E=1'b0;
always@(posedge BP)
    E<=~E;

wire[7:0]led;

LED i1(CLK,3'b000,led[0]);
LED i2(CLK,3'b001,led[1]);
LED i3(CLK,3'b010,led[2]);
LED i4(CLK,3'b011,led[3]);
LED i5(CLK,3'b100,led[4]);
LED i6(CLK,3'b101,led[5]);
LED i7(CLK,3'b110,led[6]);
LED i8(CLK,3'b111,led[7]);

assign LED=(E==1)?led:8'b1111_1111;

wire[2:0]rgb;

RGB i9(CLK,2'b00,rgb[0]);
RGB i10(CLK,2'b01,rgb[1]);
RGB i11(CLK,2'b10,rgb[2]);

assign RGB=(E==0)?rgb:3'b111;

endmodule