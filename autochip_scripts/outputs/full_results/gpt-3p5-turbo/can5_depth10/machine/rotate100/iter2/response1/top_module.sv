module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      case (ena)
        2'b01: q <= {q[97:0], data[98], 1'b0};
        2'b10: q <= {1'b0, q[99], data[98:0]};
      endcase
    end
  end
endmodule
