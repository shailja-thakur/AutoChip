module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define the state variables
    logic [1:0] current_state, next_state;
    
    // Sequential logic to update the state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01;  // Reset to state 1
        end else begin
            current_state <= next_state;  // Update state
        end
    end
    
    // Combinational logic to determine the next state
    always_comb begin
        case (current_state)
            2'b00: begin  // State 0
                if (train_taken) begin
                    next_state = 2'b01;  // Transition to state 1
                end else begin
                    next_state = 2'b00;  // Remain in state 0
                end
            end
            2'b01: begin  // State 1
                if (train_valid && train_taken) begin
                    next_state = 2'b10;  // Transition to state 2
                end else begin
                    next_state = 2'b00;  // Transition to state 0
                end
            end
            2'b10: begin  // State 2
                if (!train_taken) begin
                    next_state = 2'b01;  // Transition to state 1
                end else begin
                    next_state = 2'b11;  // Transition to state 3
                end
            end
            2'b11: begin  // State 3
                if (!train_taken) begin
                    next_state = 2'b10;  // Transition to state 2
                end else begin
                    next_state = 2'b11;  // Remain in state 3
                end
            end
        endcase
        
        // Assign the current state to the output
        state = current_state;
    end
    
endmodule
