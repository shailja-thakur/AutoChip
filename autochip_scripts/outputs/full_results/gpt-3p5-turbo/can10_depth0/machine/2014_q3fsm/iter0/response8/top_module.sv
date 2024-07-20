module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

  // Defining the states
  typedef enum logic [3:0] {
    ST_A,
    ST_B,
    ST_C,
    ST_S10,
    ST_S11,
    ST_S20,
    ST_S21,
    ST_S22
  } state_type;

  // State and next_state variables
  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= ST_A;
    end else begin
      state <= next_state;
    end
  end

  always @(state, w) begin
    case (state)
      ST_A: begin
        if (s) begin
          next_state = ST_B;
        end else begin
          next_state = state;
        end
      end
      ST_B: begin
        if (w) begin
          next_state = ST_S11;
        end else begin
          next_state = ST_S10;
        end
      end
      ST_C: begin
        if (w) begin
          next_state = ST_S11;
        end else begin
          next_state = ST_S10;
        end
      end
      ST_S10: begin
        if (w) begin
          next_state = ST_S21;
        end else begin
          next_state = ST_S20;
        end
      end
      ST_S11: begin
        if (w) begin
          next_state = ST_S22;
        end else begin
          next_state = ST_S21;
        end
      end
      ST_S20: begin
        next_state = ST_B;
      end
      ST_S21: begin
        if (w) begin
          next_state = ST_C;
        end else begin
          next_state = ST_B;
        end
      end
      ST_S22: begin
        if (w) begin
          next_state = ST_B;
        end else begin
          next_state = ST_C;
        end
      end
      default: begin
        next_state = state;
      end
    endcase
  end

  always @(state) begin
    case (state)
      ST_S22: begin
        z = 1'b1;
      end
      default: begin
        z = 1'b0;
      end
    endcase
  end

endmodule
