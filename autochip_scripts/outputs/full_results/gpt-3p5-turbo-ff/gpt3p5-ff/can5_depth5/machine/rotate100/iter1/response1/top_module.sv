module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

reg [99:0] temp;

always @(posedge clk) begin
  if (load)
    q <= data;
  else begin
    case (ena)
      2'h1: temp <= {q[98:0], 1'b0};
      2'h2: temp <= {1'b0, q[99:1]};
      default: temp <= q;
    endcase
    q <= temp;
  end
end

endmodule
