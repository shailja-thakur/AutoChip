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
        2'b01: q <= {q[97:0], data[99:2], q[0]};
        2'b10: q <= {q[99], data[1:99], q[98]};
        default: q <= q;
      endcase
    end
  end
endmodule
