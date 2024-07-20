module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [24:0] inv_a, inv_b, inv_c, inv_d, inv_e;
wire [24:0] direct_a, direct_b, direct_c, direct_d, direct_e;

assign inv_a = {5{~a}};
assign inv_b = {5{~b}};
assign inv_c = {5{~c}};
assign inv_d = {5{~d}};
assign inv_e = {5{~e}};

assign direct_a = {5{a}};
assign direct_b = {5{b}};
assign direct_c = {5{c}};
assign direct_d = {5{d}};
assign direct_e = {5{e}};

assign out = inv_a ^ inv_b ^ inv_c ^ inv_d ^ inv_e ^ direct_a ^ direct_b ^ direct_c ^ direct_d ^ direct_e;

endmodule
