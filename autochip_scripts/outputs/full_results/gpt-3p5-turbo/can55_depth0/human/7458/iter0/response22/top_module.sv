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

    wire p1a_and_p1b_and_p1c;
    wire p1d_and_p1e_and_p1f;
  
    and gate_p1a_and_p1b_and_p1c(p1a_and_p1b_and_p1c, p1a, p1b, p1c);
    and gate_p1d_and_p1e_and_p1f(p1d_and_p1e_and_p1f, p1d, p1e, p1f);
  
    or gate_p1y(p1y, p1a_and_p1b_and_p1c, p1d_and_p1e_and_p1f);
  
    wire p2a_and_p2b;
    wire p2c_and_p2d;
  
    and gate_p2a_and_p2b(p2a_and_p2b, p2a, p2b);
    and gate_p2c_and_p2d(p2c_and_p2d, p2c, p2d);
  
    or gate_p2y(p2y, p2a_and_p2b, p2c_and_p2d);
    
endmodule
