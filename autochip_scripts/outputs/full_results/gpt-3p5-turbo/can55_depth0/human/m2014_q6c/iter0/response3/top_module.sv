module top_module (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

  reg Y2;
  reg Y4;

  always @(*) begin
    case(y)
      7'b000001: begin // State A
        Y2 = 0;
        Y4 = 0;
      end
      7'b000010: begin // State B
        Y2 = 1;
        Y4 = 0;
      end
      7'b000100: begin // State C
        Y2 = 0;
        Y4 = 1;
      end
      7'b001000: begin // State D
        Y2 = 1;
        Y4 = 1;
      end
      7'b010000: begin // State E
        Y2 = 0;
        Y4 = 0; // Since E does not have a transition on Y4, we take it as '0' in this case
      end
      7'b100000: begin // State F
        Y2 = 1;
        Y4 = 1; // Since F does not have a transition on Y4, we take it as '1' in this case
      end
      default: begin
        Y2 = 0;
        Y4 = 0;
      end
    endcase
  end
endmodule
