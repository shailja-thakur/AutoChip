module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
  
  // State declaration
  logic [1:0] current_state;
  
  // State machine definition
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= 2'b01; // Reset to state 1
    end else if (train_valid) begin
      if (train_taken && (current_state < 2'b11)) begin
        current_state <= current_state + 1; // Transition to next state
      end else if (!train_taken && (current_state > 2'b00)) begin
        current_state <= current_state - 1; // Transition to previous state
      end
    end
  end
  
  // Assign current state to output
  assign state = current_state;
  
endmodule
