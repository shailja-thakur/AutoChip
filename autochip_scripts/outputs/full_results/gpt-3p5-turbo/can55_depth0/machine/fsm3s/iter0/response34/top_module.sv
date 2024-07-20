module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  // Define the states
  typedef enum {A, B, C, D} state_type;
  
  // Define the state register
  reg [1:0] state;
  
  // Define the next state
  reg [1:0] next_state;
  
  // Default initial state
  initial state = A;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= A; // Reset to state A
    else
      state <= next_state; // Transition to the next state
  end
  
  // Next state logic
  always @(state, in) begin
    case (state)
      A: begin
        if (in)
          next_state = B;
        else
          next_state = A;
      end
      B: begin
        if (in)
          next_state = B;
        else
          next_state = C;
      end
      C: begin
        if (in)
          next_state = D;
        else
          next_state = A;
      end
      D: begin
        if (in)
          next_state = B;
        else
          next_state = C;
      end
    endcase
  end
  
  // Assign output
  assign out = (state == D) ? 1'b1 : 1'b0;
  
endmodule
