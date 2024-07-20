module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

  // Define state enum
  typedef enum logic [3:0] {
    A,
    B,
    S0,
    S1,
    S10,
    G1,
    G2,
    P0,
    P1
  } state_t;

  // Define current state and next state variables
  reg state_t current_state, next_state;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end

  always @(current_state, x) begin
    next_state = A;
    case (current_state)
      A: if (x) next_state = B; else next_state = S0;
      B: next_state = S0;
      S0: if (x) next_state = S1; else next_state = S0;
      S1: if (x) next_state = S1; else next_state = S10;
      S10: if (x) next_state = G1; else next_state = S0;
      G1: if (y) next_state = P1; else next_state = G2;
      G2: if (y) next_state = P1; else next_state = P0;
      P0: next_state = P0;
      P1: next_state = P1;
      default: next_state = A;
    endcase
  end

  always @(current_state) begin
    case (current_state)
      B: f = 1;
      default: f = 0;
    endcase
  end

  always @(current_state) begin
    case (current_state)
      G1, G2, P1: g = 1;
      default: g = 0;
    endcase
  end

endmodule
