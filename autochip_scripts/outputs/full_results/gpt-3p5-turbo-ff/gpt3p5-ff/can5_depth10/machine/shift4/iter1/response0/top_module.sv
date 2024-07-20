module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

reg [3:0] temp_q;

always @(posedge clk or posedge areset) begin
  if (areset)
    temp_q <= 4'b0000;
  else if (load)
    temp_q <= data;
  else if (ena)
    temp_q <= {temp_q[2:0], temp_q[3]};
end

always @(posedge clk) begin
  q <= temp_q;
end

endmodule
