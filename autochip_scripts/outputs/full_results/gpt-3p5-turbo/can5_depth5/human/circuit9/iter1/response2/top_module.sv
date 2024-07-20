module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    case ({q, a})
      3'b010: q <= 4;
      3'b001: q <= q + 1;
      default: q <= 0;
    endcase
  end

endmodule
