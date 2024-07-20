module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a == 1'b1) begin
      case (q)
        3'b100: q <= 4;
        3'b000: q <= 1;
        3'b001: q <= 2;
        3'b010: q <= 3;
        default: q <= q;
      endcase
    end else begin
      if (q == 3'b000) begin
        q <= 5;
      end else if (q == 3'b001) begin
        q <= 6;
      end else if (q == 3'b010) begin
        q <= 0;
      end else begin
        q <= q + 1;
      end
    end
  end

endmodule
