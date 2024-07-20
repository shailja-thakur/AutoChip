module top_module(
  input clk,
  input d,
  output reg q);
  
  reg q_reg1;
  always @(posedge clk) begin
    q_reg1 <= d;
  end

  reg q_reg2;
  always @(negedge clk) begin
    q_reg2 <= q_reg1;
  end

  assign q = q_reg2;
  
endmodule
