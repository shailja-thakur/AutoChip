module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Instantiate 8 population count modules, each handling 32-bit segments of the input
wire [7:0] count0, count1, count2, count3, count4, count5, count6, count7;

population_count32 pc0 (.in(in[31:0]), .out(count0));
population_count32 pc1 (.in(in[63:32]), .out(count1));
population_count32 pc2 (.in(in[95:64]), .out(count2));
population_count32 pc3 (.in(in[127:96]), .out(count3));
population_count32 pc4 (.in(in[159:128]), .out(count4));
population_count32 pc5 (.in(in[191:160]), .out(count5));
population_count32 pc6 (.in(in[223:192]), .out(count6));
population_count32 pc7 (.in(in[254:224]), .out(count7));

// Sum the 8 population counts to get the final 8-bit result
always @* begin
    out = count0 + count1 + count2 + count3 + count4 + count5 + count6 + count7;
end

endmodule
module population_count32 (
    input [31:0] in,
    output reg [7:0] out
);

always @* begin
    out = $countones(in);
end

endmodule
