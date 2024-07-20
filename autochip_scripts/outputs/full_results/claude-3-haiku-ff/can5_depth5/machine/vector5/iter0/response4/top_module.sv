module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] inverted_a, inverted_b, inverted_c, inverted_d, inverted_e;
wire [4:0] direct_a, direct_b, direct_c, direct_d, direct_e;

// Compute the inverted and direct vectors
assign inverted_a = ~{5{a}};
assign inverted_b = ~{5{b}};
assign inverted_c = ~{5{c}};
assign inverted_d = ~{5{d}};
assign inverted_e = ~{5{e}};

assign direct_a = {5{a}};
assign direct_b = {5{b}};
assign direct_c = {5{c}};
assign direct_d = {5{d}};
assign direct_e = {5{e}};

// Compute the bitwise XOR
assign out = {inverted_a, inverted_b, inverted_c, inverted_d, inverted_e} ^ {direct_a, direct_b, direct_c, direct_d, direct_e};

endmodule
