module top_module(
  input clk,
  input d,
  output reg q);

  reg q_out;
  reg q_out_delayed;
  
  always @(posedge clk or negedge clk) begin
    q_out <= d;
    q_out_delayed <= q_out;
  end
  
  always @(posedge clk) begin
    q <= q_out_delayed;
  end

endmodule
