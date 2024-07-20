module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] q_temp;

  always @(posedge clk) begin
    q_temp <= q;
    if (load) begin
      q <= data;
    end else begin
      q <= ~( (q_temp[511:1] & q_temp[511:0] & {q_temp[510:0], 1'b0}) |
             (~q_temp[511:1] & ~q_temp[511:0] & ~(q_temp[510:0] & 1'b0)) |
             (q_temp[511:1] & ~q_temp[511:0] & ~(q_temp[510:0] & 1'b0)) );  
    end
  end
endmodule
