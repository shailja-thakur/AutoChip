module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a) begin
      case (q)
        3'b100: q <= 3'b101;
    	3'b101: q <= 3'b110;
    	3'b110: q <= 3'b000;
        default: q <= q;
      endcase
    end else begin
      q <= q;
    end
  end

endmodule
