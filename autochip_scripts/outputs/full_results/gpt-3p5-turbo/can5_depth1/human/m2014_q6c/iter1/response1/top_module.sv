module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

// Declare internal signals for next state
reg next_A, next_B, next_C, next_D, next_E, next_F;

// Define next state logic equations
always @(y, w) begin
  case (y)
    7'b000001: begin // A
      next_A = y[2] & w;
      next_B = y[1];
      next_C = y[3];
      next_D = y[4];
      next_E = y[5];
      next_F = y[6];
    end
    7'b000010: begin // B
      next_A = y[4] & w;
      next_B = y[2];
      next_C = y[3];
      next_D = y[1];
      next_E = y[5];
      next_F = y[6];
    end
    7'b000100: begin // C
      next_A = y[2] & w;
      next_B = y[4];
      next_C = y[3];
      next_D = y[5];
      next_E = y[6];
      next_F = y[1];
    end
    7'b001000: begin // D
      next_A = y[4] & w;
      next_B = y[2];
      next_C = y[1];
      next_D = y[3];
      next_E = y[5];
      next_F = y[6];
    end
    7'b010000: begin // E
      next_A = y[6] & w;
      next_B = y[2];
      next_C = y[1];
      next_D = y[4];
      next_E = y[3];
      next_F = y[5];
    end
    7'b100000: begin // F
      next_A = y[2] & w;
      next_B = y[1];
      next_C = y[3];
      next_D = y[4];
      next_E = y[5];
      next_F = y[6];
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
