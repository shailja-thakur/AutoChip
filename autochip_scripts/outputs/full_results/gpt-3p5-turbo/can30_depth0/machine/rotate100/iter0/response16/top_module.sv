module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      if (ena == 2'b01) // left shift
        q <= {q[98:0], 1'b0};
      else if (ena == 2'b10) // right shift
        q <= {1'b0, q[99:1]};
    end
  end

endmodule
