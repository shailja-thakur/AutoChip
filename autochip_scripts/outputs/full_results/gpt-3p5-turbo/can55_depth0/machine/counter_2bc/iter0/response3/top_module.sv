module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
  
  // Create internal signal to hold the current state
  logic [1:0] current_state;
  
  // Assign initial value to the current state
  initial begin
    current_state = 1;
  end
  
  always @(posedge clk or negedge areset) begin
    // Reset the state machine to state 1 when asynchronous reset is asserted
    if (!areset) begin
      current_state <= 1;
    end
    else begin
      // Transition between states based on train_valid and train_taken signals
      case (current_state)
        0: begin
          if (train_taken && (current_state < 3))
            current_state <= current_state + 1;
          else if (!train_taken && (current_state > 0))
            current_state <= current_state - 1;
        end
        1: begin
          if (train_valid && train_taken)
            current_state <= current_state + 1;
          else if (train_valid && !train_taken)
            current_state <= current_state - 1;
        end
        2: begin
          if (train_taken && (current_state < 3))
            current_state <= current_state + 1;
          else if (!train_taken && (current_state > 0))
            current_state <= current_state - 1;
        end
        3: begin
          if (!train_taken && (current_state > 0))
            current_state <= current_state - 1;
        end
      endcase
    end
  end
  
  // Assign the current state to the output signal
  assign state = current_state;
  
endmodule
