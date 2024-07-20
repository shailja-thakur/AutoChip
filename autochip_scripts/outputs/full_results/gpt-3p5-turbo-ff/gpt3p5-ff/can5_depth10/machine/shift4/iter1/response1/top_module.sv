module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

reg [3:0] q_next;

always @(posedge clk or posedge areset) begin
  if (areset)
    q <= 4'b0000;
  else if (load)
    q <= data;
  else if (ena)
    q <= q_next;
end

always @(posedge clk or posedge areset) begin
  if (areset)
    q_next <= 4'b0000;
  else if (ena)
    q_next <= {q[2:0], 1'b0};
end

endmodule
