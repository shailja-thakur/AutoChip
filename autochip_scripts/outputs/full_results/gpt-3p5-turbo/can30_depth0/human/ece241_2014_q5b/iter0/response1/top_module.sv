module top_module (
  input clk,
  input areset,
  input x,
  output z
);

// Define states
typedef enum logic [1:0] {
  A,
  B
} state_t;

// Define registers
reg state_t current_state, next_state;

// Define combinational logic for next state and output
always_comb begin
  case (current_state)
    A: begin
      if (x)
        next_state = B;
      else
        next_state = A;
      z = x ^ areset; // z = x XOR areset
    end
    
    B: begin
      if (x)
        next_state = B;
      else
        next_state = A;
      z = x ^ areset; // z = x XOR areset
    end
  endcase
end

// Define sequential logic for state update
always_ff @(posedge clk or posedge areset) begin
  if (areset)
    current_state <= A;
  else
    current_state <= next_state;
end

endmodule
