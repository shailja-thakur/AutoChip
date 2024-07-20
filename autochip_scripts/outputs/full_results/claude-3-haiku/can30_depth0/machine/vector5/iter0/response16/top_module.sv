module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [24:0] not_a, not_b, not_c, not_d, not_e;
wire [24:0] a_b_c_d_e;

assign not_a = {5{~a}};
assign not_b = {5{~b}};
assign not_c = {5{~c}};
assign not_d = {5{~d}};
assign not_e = {5{~e}};

assign a_b_c_d_e = {5{a,b,c,d,e}};

assign out = not_a ^ not_b ^ not_c ^ not_d ^ not_e ^ a_b_c_d_e;

endmodule
