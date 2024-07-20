module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] compare0;
wire [4:0] compare1;
wire [4:0] compare2;
wire [4:0] compare3;
wire [4:0] compare4;
wire [4:0] compare5;
wire [4:0] compare6;
wire [4:0] compare7;
wire [4:0] compare8;
wire [4:0] compare9;
wire [4:0] compare10;
wire [4:0] compare11;
wire [4:0] compare12;
wire [4:0] compare13;
wire [4:0] compare14;
wire [4:0] compare15;
wire [4:0] compare16;
wire [4:0] compare17;
wire [4:0] compare18;
wire [4:0] compare19;
wire [4:0] compare20;
wire [4:0] compare21;
wire [4:0] compare22;
wire [4:0] compare23;
wire [4:0] compare24;

assign compare0 = ~a ^ a;
assign compare1 = ~a ^ b;
assign compare2 = ~a ^ c;
assign compare3 = ~a ^ d;
assign compare4 = ~a ^ e;
assign compare5 = ~b ^ a;
assign compare6 = ~b ^ b;
assign compare7 = ~b ^ c;
assign compare8 = ~b ^ d;
assign compare9 = ~b ^ e;
assign compare10 = ~c ^ a;
assign compare11 = ~c ^ b;
assign compare12 = ~c ^ c;
assign compare13 = ~c ^ d;
assign compare14 = ~c ^ e;
assign compare15 = ~d ^ a;
assign compare16 = ~d ^ b;
assign compare17 = ~d ^ c;
assign compare18 = ~d ^ d;
assign compare19 = ~d ^ e;
assign compare20 = ~e ^ a;
assign compare21 = ~e ^ b;
assign compare22 = ~e ^ c;
assign compare23 = ~e ^ d;
assign compare24 = ~e ^ e;

assign out = {compare24, compare23, compare22, compare21, compare20, compare19, compare18, compare17, compare16, compare15, compare14, compare13, compare12, compare11, compare10, compare9, compare8, compare7, compare6, compare5, compare4, compare3, compare2, compare1, compare0};

endmodule
