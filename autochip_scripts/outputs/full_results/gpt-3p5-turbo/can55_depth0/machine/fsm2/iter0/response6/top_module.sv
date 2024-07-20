module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  // Define state enumeration
  typedef enum logic [1:0] {A, B} state_t;
  // Declare state and next_state variables
  state_t state, next_state;

  // Combinational always block to determine next_state
  always_comb begin
    case (state)
      A: next_state = (j) ? B : A;
      B: next_state = (k) ? A : B;
    endcase
  end

  // Clocked always block to update state
  always_ff @(posedge clk or posedge areset) begin
    if (areset)
      state <= A;
    else
      state <= next_state;
  end

  // Output assignment for out port
  assign out = (state == B);

endmodule
