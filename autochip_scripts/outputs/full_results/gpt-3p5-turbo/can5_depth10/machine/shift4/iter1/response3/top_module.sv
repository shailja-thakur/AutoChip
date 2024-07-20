module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

always @(posedge clk or posedge areset) begin
  if (areset == 1'b1) begin
    q <= 4'b0;
  end else if (load == 1'b1) begin
    q <= data;
  end else if (ena == 1'b1) begin
    q <= {1'b0, q[3:1]};
  end
end

endmodule
