module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Step 1: Create a tree of population count modules to count the number of '1's in the 255-bit input vector
wire [31:0] count_32_1, count_32_2, count_32_3, count_32_4, count_32_5, count_32_6, count_32_7, count_32_8;
population_count_32 pc_32_1 (.in(in[31:0]),   .out(count_32_1));
population_count_32 pc_32_2 (.in(in[63:32]),  .out(count_32_2));
population_count_32 pc_32_3 (.in(in[95:64]),  .out(count_32_3));
population_count_32 pc_32_4 (.in(in[127:96]), .out(count_32_4));
population_count_32 pc_32_5 (.in(in[159:128]), .out(count_32_5));
population_count_32 pc_32_6 (.in(in[191:160]), .out(count_32_6));
population_count_32 pc_32_7 (.in(in[223:192]), .out(count_32_7));
population_count_32 pc_32_8 (.in(in[254:224]), .out(count_32_8));

wire [63:0] count_64_1, count_64_2;
population_count_64 pc_64_1 (.in({count_32_2, count_32_1}), .out(count_64_1));
population_count_64 pc_64_2 (.in({count_32_4, count_32_3}), .out(count_64_2));

wire [127:0] count_128_1;
population_count_128 pc_128_1 (.in({count_64_2, count_64_1}), .out(count_128_1));

// Step 2: Combine the final 128-bit population count to a single 8-bit output
always @(*) begin
    out = count_128_1[7:0] + count_128_1[15:8] + count_128_1[23:16] + count_128_1[31:24] +
          count_128_1[39:32] + count_128_1[47:40] + count_128_1[55:48] + count_128_1[63:56] +
          count_128_1[71:64] + count_128_1[79:72] + count_128_1[87:80] + count_128_1[95:88] +
          count_128_1[103:96] + count_128_1[111:104] + count_128_1[119:112] + count_128_1[127:120];
end

// Submodules
module population_count_32 (
    input [31:0] in,
    output reg [31:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
module population_count_64 (
    input [63:0] in,
    output reg [31:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
module population_count_128 (
    input [127:0] in,
    output reg [127:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
