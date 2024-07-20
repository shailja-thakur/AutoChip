module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
  
  // Define state variables
  logic [1:0] current_state, next_state;
  
  // Sequential logic for state machine
  always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
      current_state <= 2'b01; // Reset state to 01
    end
    else begin
      current_state <= next_state; // Update current state
    end
  end
  
  // Combinational logic for next state
  always_comb begin
    case (current_state)
      0: begin
        if (train_taken && current_state < 3) // Transition to next state if taken
          next_state = current_state + 1;
        else
          next_state = current_state; // Remain in current state
      end
      1: begin
        if (train_taken) // Transition to next state if taken
          next_state = current_state + 1;
        else if (!train_taken && current_state > 0) // Transition to previous state if not taken
          next_state = current_state - 1;
        else
          next_state = current_state; // Remain in current state
      end
      2: begin
        if (train_taken) // Transition to next state if taken
          next_state = current_state + 1;
        else if (!train_taken && current_state > 0) // Transition to previous state if not taken
          next_state = current_state - 1;
        else
          next_state = current_state; // Remain in current state
      end
      3: begin
        if (!train_taken && current_state > 0) // Transition to previous state if not taken
          next_state = current_state - 1;
        else
          next_state = current_state; // Remain in current state
      end
      default: next_state = current_state; // Default case, remain in current state
    endcase
  end
  
  // Output assignment
  assign state = current_state;
  
endmodule
