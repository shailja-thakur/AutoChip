module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);

  // Declare internal wires
  wire [1:0] current_state;
  
  // Assigning 'current_state' to the value of 'state'
  assign current_state = state;
  
  // Always block to determine next state based on current state and 'in' signal
  always_comb begin
    case (current_state)
      2'b00: begin // State A
        if (in)
          next_state = 2'b01; // Transition to State B
        else
          next_state = 2'b00; // Stay in State A
      end
      
      2'b01: begin // State B
        if (in)
          next_state = 2'b01; // Stay in State B
        else
          next_state = 2'b10; // Transition to State C
      end
      
      2'b10: begin // State C
        if (in)
          next_state = 2'b11; // Transition to State D
        else
          next_state = 2'b00; // Transition to State A
      end
      
      2'b11: begin // State D
        if (in)
          next_state = 2'b01; // Transition to State B
        else
          next_state = 2'b10; // Transition to State C
      end
      
    endcase
  end
  
  // Assign 'out' signal to high when the state machine is in state D
  assign out = (current_state == 2'b11);
  
endmodule
