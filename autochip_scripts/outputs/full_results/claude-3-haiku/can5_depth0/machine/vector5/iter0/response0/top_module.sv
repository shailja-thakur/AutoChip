module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bits, b_bits, c_bits, d_bits, e_bits;
wire [24:0] inv_bits, and_bits;

assign a_bits = {5{a}};
assign b_bits = {5{b}};
assign c_bits = {5{c}};
assign d_bits = {5{d}};
assign e_bits = {5{e}};

assign inv_bits = ~{a_bits, b_bits, c_bits, d_bits, e_bits};
assign and_bits = {5{a,b,c,d,e}};

assign out = inv_bits ^ and_bits;

endmodule
