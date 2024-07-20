module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal signals
    logic [1:0] next_state;
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to state 1
        end else begin
            state <= next_state; // Update state based on next_state value
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            2'b00: begin
                if (train_taken && state < 2'b11) begin
                    next_state = state + 1; // Transition to next state
                end else begin
                    next_state = state; // Stay in current state
                end
            end
            2'b01: begin
                if (train_valid) begin
                    next_state = 2'b00; // Transition to state 0
                end else begin
                    next_state = state; // Stay in current state
                end
            end
            2'b10: begin
                if (!train_taken && state > 2'b00) begin
                    next_state = state - 1; // Transition to previous state
                end else begin
                    next_state = state; // Stay in current state
                end
            end
            2'b11: begin
                if (train_valid) begin
                    next_state = 2'b10; // Transition to state 2
                end else begin
                    next_state = state; // Stay in current state
                end
            end
            default: begin
                next_state = state; // Stay in current state
            end
        endcase
    end
    
endmodule
