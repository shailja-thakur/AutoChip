module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Implement a hierarchical population count circuit
wire [31:0] count_1;
wire [31:0] count_2;
wire [31:0] count_3;
wire [31:0] count_4;
wire [31:0] count_5;
wire [31:0] count_6;
wire [31:0] count_7;
wire [31:0] count_8;

// Level 1: Divide the 255-bit input into 8 32-bit segments
popcount_32 pc1(.in(in[31:0]),   .out(count_1));
popcount_32 pc2(.in(in[63:32]),  .out(count_2));
popcount_32 pc3(.in(in[95:64]),  .out(count_3));
popcount_32 pc4(.in(in[127:96]), .out(count_4));
popcount_32 pc5(.in(in[159:128]),.out(count_5));
popcount_32 pc6(.in(in[191:160]),.out(count_6));
popcount_32 pc7(.in(in[223:192]),.out(count_7));
popcount_32 pc8(.in(in[254:224]),.out(count_8));

// Level 2: Add up the counts from the 8 segments
wire [31:0] sum_1 = count_1 + count_2;
wire [31:0] sum_2 = count_3 + count_4;
wire [31:0] sum_3 = count_5 + count_6;
wire [31:0] sum_4 = count_7 + count_8;

// Level 3: Add up the 4 intermediate sums
wire [31:0] sum_5 = sum_1 + sum_2;
wire [31:0] sum_6 = sum_3 + sum_4;

// Level 4: Add the final two sums
wire [31:0] sum_7 = sum_5 + sum_6;

// Assign the 8-bit output
always @(*) begin
    out = sum_7[7:0];
end

// Population count for 32-bit input
module popcount_32 (
    input [31:0] in,
    output [31:0] out
);

// Implement a 32-bit population count circuit
wire [15:0] count_1, count_2;
popcount_16 pc1(.in(in[15:0]),   .out(count_1));
popcount_16 pc2(.in(in[31:16]),  .out(count_2));
assign out = count_1 + count_2;
endmodule
module popcount_16 (
    input [15:0] in,
    output [15:0] out
);

// Implement a 16-bit population count circuit
wire [7:0] count_1, count_2;
popcount_8 pc1(.in(in[7:0]),   .out(count_1));
popcount_8 pc2(.in(in[15:8]),  .out(count_2));
assign out = count_1 + count_2;
endmodule
module popcount_8 (
    input [7:0] in,
    output [7:0] out
);

// Implement an 8-bit population count circuit
assign out = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7];
endmodule
