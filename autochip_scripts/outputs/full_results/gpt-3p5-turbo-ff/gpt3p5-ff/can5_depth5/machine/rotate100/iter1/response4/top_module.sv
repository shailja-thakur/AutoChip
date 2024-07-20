module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

always @(posedge clk) begin
  if (load)
    q <= data;
  else begin
    case (ena)
      2'h1: q <= {q[97:0], data[99:98]};
      2'h2: q <= {data[1:0], q[99:2]};
      default: q <= q;
    endcase
  end
end

endmodule
