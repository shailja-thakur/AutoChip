module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

reg [99:0] q_temp;

always @(posedge clk) begin
  if (load)
    q <= data;
  else begin
    case (ena)
      2'h1: q_temp <= {q[98:0], 1'b0};
      2'h2: q_temp <= {1'b0, q[99:1]};
      default: q_temp <= q;
    endcase
  end
end

always @(posedge clk) begin
  if (load)
    q <= data;
  else
    q <= q_temp;
end

endmodule
