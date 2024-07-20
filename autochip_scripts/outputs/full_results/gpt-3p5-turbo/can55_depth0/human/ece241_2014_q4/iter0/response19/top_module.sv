module top_module (
  input clk,
  input x,
  output z
);

  reg d1,d2,d3;
  wire q1,q2,q3;

  xor x1(q1,d1,x);
  and a1(q2,d2,q1);
  or o1(q3,d3,q1);

  xnor x2(z,q1,q2,q3);

  always @(posedge clk) begin
    d1 <= q1;
    d2 <= ~q2;
    d3 <= ~q3;
  end
  
endmodule
