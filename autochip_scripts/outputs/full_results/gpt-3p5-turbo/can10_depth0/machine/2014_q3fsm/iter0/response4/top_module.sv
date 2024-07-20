module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

  // Defining states as constants
  parameter A = 0;
  parameter B = 1;
  parameter C = 2;
  parameter S10 = 3;
  parameter S11 = 4;
  parameter S20 = 5;
  parameter S21 = 6;
  parameter S22 = 7;

  reg [2:0] state_reg;
  reg [2:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_reg <= A;
    end else begin
      state_reg <= next_state;
    end
  end

  always @* begin
    case(state_reg)
      A: begin
        if (s) begin
          next_state = B;
        end
      end
      B: begin
        if (w) begin
          next_state = S11;
        end else begin
          next_state = S10;
        end
      end
      C: begin
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

  always @(posedge clk) begin
    case(state_reg)
      A: begin
        // State A logic
        z <= 0;
      end
      B: begin
        // State B logic
        z <= 0;
      end
      C: begin
        // State C logic
        z <= 0;
      end
      S10: begin
        // State S10 logic
        z <= 0;
      end
      S11: begin
        // State S11 logic
        z <= 0;
      end
      S20: begin
        // State S20 logic
        z <= 0;
      end
      S21: begin
        // State S21 logic
        z <= 0;
      end
      S22: begin
        // State S22 logic
        z <= 0;
      end
      default: begin
        z <= 0;
      end
    endcase
  end

endmodule
