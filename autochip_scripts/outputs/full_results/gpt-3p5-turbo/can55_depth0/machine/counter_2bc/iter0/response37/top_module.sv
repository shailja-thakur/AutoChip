module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal state reg
    logic [1:0] current_state;
    
    // Reset logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01; // Reset to state 1
        else
            current_state <= state;
    end
    
    // State transition logic
    always_comb begin
        case (current_state)
            2'b00: begin
                if (train_valid && train_taken)
                    current_state = 2'b01; // Transition to state 1
                else
                    current_state = 2'b00; // Remain in state 0
            end
            2'b01: begin
                if (train_valid && train_taken)
                    current_state = 2'b10; // Transition to state 2
                else
                    current_state = 2'b00; // Transition to state 0
            end
            2'b10: begin
                if (train_valid && train_taken)
                    current_state = 2'b11; // Transition to state 3
                else
                    current_state = 2'b01; // Transition to state 1
            end
            2'b11: begin
                if (train_valid && !train_taken)
                    current_state = 2'b10; // Transition to state 2
                else
                    current_state = 2'b11; // Remain in state 3
            end
        endcase
    end
    
    assign state = current_state;
    
endmodule
