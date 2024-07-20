module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

always @(posedge clk) begin
  case (q)
    1'b0: if (a) q <= 3'b100;
          else q <= 3'b000;
    default: if (!a) q <= q + 1;
  endcase
end

endmodule
