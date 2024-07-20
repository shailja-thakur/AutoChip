module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Instantiate 8 parallel 32-bit population count modules
wire [7:0] count_32bit [0:7];

population_count_32bit pc0 (.in(in[31:0]),   .out(count_32bit[0]));
population_count_32bit pc1 (.in(in[63:32]),  .out(count_32bit[1]));
population_count_32bit pc2 (.in(in[95:64]),  .out(count_32bit[2]));
population_count_32bit pc3 (.in(in[127:96]), .out(count_32bit[3]));
population_count_32bit pc4 (.in(in[159:128]), .out(count_32bit[4]));
population_count_32bit pc5 (.in(in[191:160]), .out(count_32bit[5]));
population_count_32bit pc6 (.in(in[223:192]), .out(count_32bit[6]));
population_count_32bit pc7 (.in(in[254:224]), .out(count_32bit[7]));

// Sum the 8 32-bit population counts
always @(*) begin
    out = count_32bit[0] + count_32bit[1] + count_32bit[2] + count_32bit[3] +
          count_32bit[4] + count_32bit[5] + count_32bit[6] + count_32bit[7];
end

endmodule
module population_count_32bit (
    input [31:0] in,
    output reg [7:0] out
);

// Combinational logic to count the number of '1's in the 32-bit input
always @(*) begin
    out = 0;
    for (int i = 0; i < 32; i++) begin
        out += in[i];
    end
end

endmodule
