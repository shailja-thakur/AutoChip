module top_module (
   input clk,
   input a,
   output reg [2:0] q
);

always @(posedge clk) begin
  case (q)
    3'b000: if (a) q <= 3'b100;
    3'b100: if (~a) q <= 3'b101;
    3'b101: if (~a) q <= 3'b110;
    3'b110: if (~a) q <= 3'b000;
    default: q <= q;
  endcase
end

endmodule
