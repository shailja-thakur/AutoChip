module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state, next_state;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 3'b001; // Initializing the state to A
    end else begin
      state <= next_state;
    end
  end

  always @(state or r) begin
    case (state)
      3'b001: begin
        if (r[1]) begin
          next_state = 3'b010; // Transition to state B if r1 is active
        end else if (r[2]) begin
          next_state = 3'b011; // Transition to state C if r2 is active
        end else if (r[3]) begin
          next_state = 3'b100; // Transition to state D if r3 is active
        end else begin
          next_state = 3'b001; // Stay in state A
        end
      end
      3'b010: begin
        if (r[1]) begin
          next_state = 3'b010; // Stay in state B and keep g1 active
        end else begin
          next_state = 3'b001; // Transition to state A and deactivate g1
        end
      end
      3'b011: begin
        if (r[2]) begin
          next_state = 3'b011; // Stay in state C and keep g2 active
        end else begin
          next_state = 3'b001; // Transition to state A and deactivate g2
        end
      end
      3'b100: begin
        next_state = 3'b001; // Transition to state A and deactivate g3
      end
    endcase
  end

  assign g[1] = (state == 3'b010) ? 1 : 0; // g1 is active when in state B
  assign g[2] = (state == 3'b011) ? 1 : 0; // g2 is active when in state C
  assign g[3] = (state == 3'b100) ? 1 : 0; // g3 is active when in state D

endmodule
