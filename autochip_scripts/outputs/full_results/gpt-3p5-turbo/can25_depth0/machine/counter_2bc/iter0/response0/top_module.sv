module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Declare internal signals
    logic [1:0] next_state;
    
    // Declare initial state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset state to 01
        end else begin
            state <= next_state; // Transition to next state
        end
    end
    
    // Determine next state based on inputs
    always_comb begin
        next_state = state;
        case(state)
            2'b00: begin // State 0
                if (train_valid && train_taken) begin
                    next_state = 2'b01; // Transition to state 1
                end
            end
            
            2'b01: begin // State 1
                if (train_valid && train_taken) begin
                    next_state = 2'b10; // Transition to state 2
                end else if (train_valid && !train_taken) begin
                    next_state = 2'b00; // Transition to state 0
                end
            end
            
            2'b10: begin // State 2
                if (train_valid && train_taken) begin
                    next_state = 2'b11; // Transition to state 3
                end else if (train_valid && !train_taken) begin
                    next_state = 2'b01; // Transition to state 1
                end
            end
            
            2'b11: begin // State 3
                if (train_valid && !train_taken) begin
                    next_state = 2'b10; // Transition to state 2
                end
            end
        endcase
    end
endmodule
