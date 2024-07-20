module top_module(
  input [3:1] y,
  input w,
  output reg Y2);

  always @(*)
    begin
      case(y)
        3'b000: if(w) Y2 = 1'b0;
                else Y2 = 1'b1;
        3'b001: if(w) Y2 = 1'b0;
                else Y2 = 1'b1;
        3'b010: if(w) Y2 = 1'b0;
                else Y2 = 1'b1;
        3'b011: if(w) Y2 = 1'b0;
                else Y2 = 1'b1;
        3'b100: if(w) Y2 = 1'b0;
                else Y2 = 1'b1;
        3'b101: if(w) Y2 = 1'b0;
                else Y2 = 1'b1;
        default: Y2 = 1'b0;
      endcase
    end

endmodule
