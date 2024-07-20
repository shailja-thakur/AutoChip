module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  parameter A = 1'b0;
  parameter B = 1'b1;
  
  reg state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= B;
    else if (state == A && in)
      state <= A;
    else if (state == A && !in)
      state <= B;
    else if (state == B && in)
      state <= B;
    else if (state == B && !in)
      state <= A;
  end
  
  assign out = state;
  
endmodule
