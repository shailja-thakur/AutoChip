module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// Define current state and next state variables
reg [2:0] state, next_state;

// Initialize state register with state A
always @(posedge clk, negedge reset) begin
  if (reset)
    state <= A;
  else
    state <= next_state;
end

// Assign values to next_state based on current state and inputs
always @(state, s, w) begin
  case (state)
    A: begin
      if (s)
        next_state = B;
      else
        next_state = A;
    end
    B: begin
      if (w)
        next_state = S11;
      else
        next_state = S10;
    end
    C: begin
      if (w)
        next_state = S11;
      else
        next_state = S10;
    end
    S10: begin
      if (w)
        next_state = S21;
      else
        next_state = S20;
    end
    S11: begin
      if (w)
        next_state = S22;
      else
        next_state = S21;
    end
    S20: begin
      next_state = B;
    end
    S21: begin
      if (w)
        next_state = C;
      else
        next_state = B;
    end
    S22: begin
      if (w)
        next_state = B;
      else
        next_state = C;
    end
    default: next_state = A;
  endcase
end

// Assign output z based on current state
always @(state) begin
  case (state)
    A, B, C, S20: begin
      z = 0;
    end
    default: begin
      z = 1;
    end
  endcase
end

endmodule
