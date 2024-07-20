module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    int cycle_count;

    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn)
            cycle_count <= 0;
        else if (state == STATE_D)
            cycle_count <= cycle_count + 1;
        else
            cycle_count <= 0;
    end

  always_ff @(posedge clk or negedge resetn) begin
      if (~resetn) begin
          f <= 0;
          g <= 0;
      end else begin
          case (state)
              STATE_A: begin
                  f <= 0;
                  g <= 0;
              end
              STATE_B: begin
                  f <= 1;
              end
              STATE_C: begin
                  f <= 0;
              end
              STATE_D: begin
                  // Outputs don't change in this state
              end
              STATE_E: begin
                  g <= 1;
              end
              STATE_F: begin
                  if (y == 1)
                      g <= 1;
                  else if (cycle_count == 2)
                      g <= 0;
              end
              STATE_G: begin
                  // Outputs don't change in this state
              end
              default: begin
                  f <= 0;
                  g <= 0;
              end
          endcase
      end
  end

  always_comb begin
      next_state = state;
      case (state)
          STATE_A: begin
              if (~resetn)
                  next_state = STATE_A;
              else
                  next_state = STATE_B;
          end
          STATE_B: next_state = STATE_C;
          STATE_C: next_state = STATE_D;
          STATE_D: begin
              if (x == 1)
                  next_state = STATE_E;
              else
                  next_state = STATE_D;
          end
          STATE_E: next_state = STATE_F;
          STATE_F: begin
              if (cycle_count == 2) begin
                  if (y == 1)
                      next_state = STATE_G;
                  else
                      next_state = STATE_A;
              end else
                  next_state = STATE_F;
          end
          STATE_G: begin
              if (resetn)
                  next_state = STATE_A;
              else
                  next_state = STATE_G;
          end
          default: next_state = STATE_A;
      endcase
  end

endmodule
