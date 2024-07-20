module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Instantiate an array of 8 4-bit population count modules
wire [31:0] pop_count_0, pop_count_1, pop_count_2, pop_count_3, pop_count_4, pop_count_5, pop_count_6, pop_count_7;

pop_count_4bit pc0 (.in(in[63:0]),   .out(pop_count_0));
pop_count_4bit pc1 (.in(in[127:64]), .out(pop_count_1));
pop_count_4bit pc2 (.in(in[191:128]), .out(pop_count_2));
pop_count_4bit pc3 (.in(in[254:192]), .out(pop_count_3));

// Sum the 4-bit population counts to get the 8-bit output
always @(*) begin
    out = pop_count_0 + pop_count_1 + pop_count_2 + pop_count_3;
end

endmodule
module pop_count_4bit (
    input [63:0] in,
    output reg [31:0] out
);

// Implement a 4-bit population count module
always @(*) begin
    out = $countones(in);
end

endmodule
