module flipflop_module(
  input clk,
  input D,
  output reg Q
);
  
  always @(posedge clk) begin
    Q <= D;
  end
  
endmodule
module mux21_module(
  input S,
  input I0,
  input I1,
  output reg O
);
  
  always @(*) begin
    if(S == 0)
      O <= I0;
    else
      O <= I1;
  end
  
endmodule
module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q
);
  
  wire q1;
  wire q2;
  
  flipflop_module flipflop1(
    .clk(clk),
    .D(q_in),
    .Q(q1)
  );
  
  flipflop_module flipflop2(
    .clk(clk),
    .D(q1),
    .Q(q2)
  );
  
  mux21_module mux(
    .S(L),
    .I0(q2),
    .I1(r_in),
    .O(Q)
  );
  
endmodule
