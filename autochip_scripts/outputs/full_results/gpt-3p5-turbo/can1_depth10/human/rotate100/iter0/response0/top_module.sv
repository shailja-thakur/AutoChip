module top_module(
  input wire clk,
  input wire load,
  input wire [1:0] ena,
  input wire [99:0] data,
  output reg [99:0] q
);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      case (ena)
        2'b01: q <= {q[0], q[99:1]};
        2'b10: q <= {q[98:0], q[99]};
        default: q <= q;
      endcase
    end
  end
  
endmodule
