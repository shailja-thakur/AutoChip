module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
  
  reg Y1;
  reg Y3;

  always @(y[1] or w) begin
    case (y)
      6'b010000:
        Y1 <= w;
      default:
        Y1 <= 1'b0;
    endcase
  end

  always @(y[3] or w) begin
    case (y)
      6'b000100:
        Y3 <= w;
      default:
        Y3 <= 1'b0;
    endcase
  end

endmodule
