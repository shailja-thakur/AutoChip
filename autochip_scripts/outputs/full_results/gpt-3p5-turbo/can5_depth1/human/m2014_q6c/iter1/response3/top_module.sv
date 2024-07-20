module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

  // Declare internal signals for next state
  reg next_A, next_B, next_C, next_D, next_E, next_F;

  // Define next state logic equations
  always @(y) begin
    case (y)
      7'b000001: begin // A
        next_A = w;
        next_B = 1'b0;
        next_C = 1'b0;
        next_D = 1'b0;
        next_E = 1'b0;
        next_F = 1'b0;
      end
      7'b000010: begin // B
        next_A = 1'b0;
        next_B = 1'b0;
        next_C = 1'b0;
        next_D = 1'b0;
        next_E = 1'b0;
        next_F = 1'b1;
      end
      7'b000100: begin // C
        next_A = w;
        next_B = 1'b1;
        next_C = 1'b0;
        next_D = 1'b1;
        next_E = 1'b0;
        next_F = 1'b0;
      end
      7'b001000: begin // D
        next_A = w;
        next_B = 1'b0;
        next_C = 1'b1;
        next_D = 1'b1;
        next_E = 1'b0;
        next_F = 1'b0;
      end
      7'b010000: begin // E
        next_A = w;
        next_B = 1'b0;
        next_C = 1'b0;
        next_D = 1'b1;
        next_E = 1'b1;
        next_F = 1'b0;
      end
      7'b100000: begin // F
        next_A = 1'b0;
        next_B = 1'b0;
        next_C = 1'b1;
        next_D = 1'b0;
        next_E = 1'b0;
        next_F = 1'b1;
      end
      default: begin
        next_A = 1'b0;
        next_B = 1'b0;
        next_C = 1'b0;
        next_D = 1'b0;
        next_E = 1'b0;
        next_F = 1'b0;
      end
    endcase
  end

  // Assign next state signals to outputs
  assign Y2 = next_A;
  assign Y4 = next_B;

endmodule
