module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count in a tree-like structure
wire [7:0] count1, count2, count3, count4, count5, count6, count7, count8;

// First layer (input to 8 groups of 32-bit counters)
popcount_32 pc1 (.in(in[31:0]),   .out(count1));
popcount_32 pc2 (.in(in[63:32]),  .out(count2));
popcount_32 pc3 (.in(in[95:64]),  .out(count3));
popcount_32 pc4 (.in(in[127:96]), .out(count4));
popcount_32 pc5 (.in(in[159:128]), .out(count5));
popcount_32 pc6 (.in(in[191:160]), .out(count6));
popcount_32 pc7 (.in(in[223:192]), .out(count7));
popcount_32 pc8 (.in(in[254:224]), .out(count8));

// Second layer (add the 8 group counts)
wire [7:0] sum1, sum2;
adder_8bit a1 (.a(count1), .b(count2), .cin(1'b0), .sum(sum1), .cout());
adder_8bit a2 (.a(count3), .b(count4), .cin(1'b0), .sum(sum2), .cout());

wire [7:0] sum3, sum4;
adder_8bit a3 (.a(count5), .b(count6), .cin(1'b0), .sum(sum3), .cout());
adder_8bit a4 (.a(count7), .b(count8), .cin(1'b0), .sum(sum4), .cout());

// Third layer (add the 4 sums)
wire [7:0] final_sum;
adder_8bit a5 (.a(sum1), .b(sum2), .cin(1'b0), .sum(final_sum), .cout());

always @(*) begin
    out = final_sum;
end

endmodule
module popcount_32 (
    input [31:0] in,
    output reg [7:0] out
);

integer i;
always @(*) begin
    out = 0;
    for (i = 0; i < 32; i = i + 1) begin
        out = out + in[i];
    end
end

endmodule
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
);

assign {cout, sum} = a + b + cin;

endmodule
