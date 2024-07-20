module top_module (
  input [255:0] in,
  input [7:0] sel,
  output reg out
);

  always @(*) begin
    case (sel)
      8'h00: out = in[0];
      8'h01: out = in[1];
      8'h02: out = in[2];
      8'h03: out = in[3];
      // ...
      // continue for sel=4 to sel=255
      // ...
      default: out = in[0];
    endcase
  end

endmodule
