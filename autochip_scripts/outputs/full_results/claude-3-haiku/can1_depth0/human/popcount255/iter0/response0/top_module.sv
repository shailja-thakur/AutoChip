module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Instantiate 8 population count circuits, each processing 32 bits of the input vector
wire [7:0] count_32[7:0];
population_count_32 pc0 (.in(in[31:0]),   .out(count_32[0]));
population_count_32 pc1 (.in(in[63:32]),  .out(count_32[1]));
population_count_32 pc2 (.in(in[95:64]),  .out(count_32[2]));
population_count_32 pc3 (.in(in[127:96]), .out(count_32[3]));
population_count_32 pc4 (.in(in[159:128]), .out(count_32[4]));
population_count_32 pc5 (.in(in[191:160]), .out(count_32[5]));
population_count_32 pc6 (.in(in[223:192]), .out(count_32[6]));
population_count_32 pc7 (.in(in[254:224]), .out(count_32[7]));

// Sum the outputs of the 8 population count circuits
always @(*) begin
    out = count_32[0] + count_32[1] + count_32[2] + count_32[3] +
          count_32[4] + count_32[5] + count_32[6] + count_32[7];
end

endmodule
module population_count_32 (
    input [31:0] in,
    output reg [7:0] out
);

always @(*) begin
    out = 0;
    for (int i = 0; i < 32; i++) begin
        out += in[i];
    end
end

endmodule
