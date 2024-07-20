module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [31:0] count_32_1, count_32_2, count_32_3, count_32_4, count_32_5, count_32_6, count_32_7, count_32_8;

// Divide and conquer approach
// Count 1s in each 32-bit chunk
pop_count_32 pc32_1 (.in(in[31:0]),   .out(count_32_1));
pop_count_32 pc32_2 (.in(in[63:32]),  .out(count_32_2));
pop_count_32 pc32_3 (.in(in[95:64]),  .out(count_32_3));
pop_count_32 pc32_4 (.in(in[127:96]), .out(count_32_4));
pop_count_32 pc32_5 (.in(in[159:128]),.out(count_32_5));
pop_count_32 pc32_6 (.in(in[191:160]),.out(count_32_6));
pop_count_32 pc32_7 (.in(in[223:192]),.out(count_32_7));
pop_count_32 pc32_8 (.in(in[254:224]),.out(count_32_8));

// Sum the counts from each 32-bit chunk
always @* begin
    out = count_32_1 + count_32_2 + count_32_3 + count_32_4 +
          count_32_5 + count_32_6 + count_32_7 + count_32_8;
end

endmodule
module pop_count_32 (
    input [31:0] in,
    output reg [31:0] out
);

always @* begin
    out = $countones(in);
end

endmodule
