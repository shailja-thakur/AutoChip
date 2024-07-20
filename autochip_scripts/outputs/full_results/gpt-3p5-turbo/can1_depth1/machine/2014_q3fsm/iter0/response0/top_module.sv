module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

  // State variables
  reg [2:0] state, next_state;

  // State assignments
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Next state logic and outputs
  always @* begin
    case (state)
      A: begin
        if (s) begin
          next_state = B;
        end else begin
          next_state = state;
        end
      end
      B, C: begin
        if (w) begin
          next_state = S11;
        end else begin
          next_state = S10;
        end
      end
      S10: begin
        if (w) begin
          next_state = S21;
        end else begin
          next_state = S20;
        end
      end
      S11: begin
        if (w) begin
          next_state = S22;
        end else begin
          next_state = S21;
        end
      end
      S20: begin
        next_state = B;
      end
      S21: begin
        if (w) begin
          next_state = C;
        end else begin
          next_state = B;
        end
      end
      S22: begin
        if (w) begin
          next_state = B;
        end else begin
          next_state = C;
        end
      end
      default: begin
        next_state = state;
      end
    endcase
  end

  // Output assignments
  always @* begin
    case (state)
      A, B, C, S10, S11: begin
        z = 0;
      end
      S20, S21, S22: begin
        z = 1;
      end
      default: begin
        z = 0;
      end
    endcase
  end

endmodule
