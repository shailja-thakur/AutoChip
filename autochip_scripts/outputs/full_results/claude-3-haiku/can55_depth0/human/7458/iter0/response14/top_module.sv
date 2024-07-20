module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

wire p1a_and_b_and_c, p1d_and_e_and_f, p2a_and_b, p2c_and_d;

assign p1a_and_b_and_c = p1a & p1b & p1c;
assign p1d_and_e_and_f = p1d & p1e & p1f;
assign p1y = p1a_and_b_and_c | p1d_and_e_and_f;

assign p2a_and_b = p2a & p2b;
assign p2c_and_d = p2c & p2d;
assign p2y = p2a_and_b | p2c_and_d;

endmodule
