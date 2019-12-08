module RainbowRGB
(input CLK
,output[7:0]LED
);

LED i1(CLK,3'b000,LED[0]);
LED i2(CLK,3'b001,LED[1]);
LED i3(CLK,3'b010,LED[2]);
LED i4(CLK,3'b011,LED[3]);
LED i5(CLK,3'b100,LED[4]);
LED i6(CLK,3'b101,LED[5]);
LED i7(CLK,3'b110,LED[6]);
LED i8(CLK,3'b111,LED[7]);

endmodule