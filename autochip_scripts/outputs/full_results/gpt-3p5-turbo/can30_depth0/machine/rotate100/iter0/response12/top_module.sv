module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

  reg [99:0] reg_q;

  always @(posedge clk) begin
    if (load)
      reg_q <= data;
    else begin
      case (ena)
        2'b01: reg_q <= {reg_q[98:0], 1'b0};
        2'b10: reg_q <= {1'b0, reg_q[99:1]};
        default: reg_q <= reg_q;
      endcase
    end
  end

  assign q = reg_q;

endmodule
