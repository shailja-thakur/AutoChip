module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    case ({a, q})
      2'b01: if (q < 7) q <= q + 1;
      default: if (a) q <= 4; else q <= 0;
    endcase
  end

endmodule
