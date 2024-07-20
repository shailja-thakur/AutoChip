module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform a hierarchical population count
wire [31:0] pop_count_32_0, pop_count_32_1, pop_count_32_2, pop_count_32_3, pop_count_32_4, pop_count_32_5, pop_count_32_6, pop_count_32_7;

pop_count_32 pc0 (.in(in[31:0]),   .out(pop_count_32_0));
pop_count_32 pc1 (.in(in[63:32]),  .out(pop_count_32_1));
pop_count_32 pc2 (.in(in[95:64]),  .out(pop_count_32_2));
pop_count_32 pc3 (.in(in[127:96]), .out(pop_count_32_3));
pop_count_32 pc4 (.in(in[159:128]), .out(pop_count_32_4));
pop_count_32 pc5 (.in(in[191:160]), .out(pop_count_32_5));
pop_count_32 pc6 (.in(in[223:192]), .out(pop_count_32_6));
pop_count_32 pc7 (.in(in[254:223]), .out(pop_count_32_7));

// Combine the 32-bit population counts
always @(*) begin
    out = pop_count_32_0 + pop_count_32_1 + pop_count_32_2 + pop_count_32_3 +
          pop_count_32_4 + pop_count_32_5 + pop_count_32_6 + pop_count_32_7;
end

endmodule
module pop_count_32 (
    input [31:0] in,
    output reg [7:0] out
);

always @(*) begin
    out = $countones(in);
end

endmodule
