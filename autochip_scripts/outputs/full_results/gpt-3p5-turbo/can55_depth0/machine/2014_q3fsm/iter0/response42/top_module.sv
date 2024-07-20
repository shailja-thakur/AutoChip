module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

  // Declare state variables
  reg [4:0] state, next_state;

  // Define state values
  parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7;

  // Default values for state variables
  initial begin
    state = A;
    next_state = A;
  end

  // Sequential logic for state transition
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Combinational logic for next state computation
  always @(state, s, w) begin
    case (state)
      A: begin
        if (s) begin
          next_state = B;
        end else begin
          next_state = A;
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
        next_state = A;
      end
    endcase
  end

  // Combinational logic for output generation
  always @(state) begin
    case (state)
      A, B, C, S20, S21, S22: begin
        z = 0;
      end

      S10, S11: begin
        z = 1;
      end

      default: begin
        z = 0;
      end
    endcase
  end
endmodule
