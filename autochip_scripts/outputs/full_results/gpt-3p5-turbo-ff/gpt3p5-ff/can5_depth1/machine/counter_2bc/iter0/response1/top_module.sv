module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    typedef enum logic [1:0] {
        STATE_0,
        STATE_1,
        STATE_2,
        STATE_3
    } state_t;
    
    // Declare state variable
    state_t current_state, next_state;
    
    // Always block sensitive to clk and areset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1; // Reset state to 1
        end
        else begin
            current_state <= next_state; // Update current state
        end
    end
    
    // Combinational logic for next state calculation
    always_comb begin
        case (current_state)
            STATE_0: begin
                if (train_taken && current_state < STATE_3) begin
                    next_state = STATE_1; // Transition to next state
                end
                else begin
                    next_state = STATE_0; // Remain in current state
                end
            end
            
            STATE_1: begin
                if (train_taken && current_state < STATE_3) begin
                    next_state = STATE_2; // Transition to next state
                end
                else if (!train_taken && current_state > STATE_0) begin
                    next_state = STATE_0; // Transition to previous state
                end
                else begin
                    next_state = STATE_1; // Remain in current state
                end
            end
            
            STATE_2: begin
                if (train_taken && current_state < STATE_3) begin
                    next_state = STATE_3; // Transition to next state
                end
                else if (!train_taken && current_state > STATE_0) begin
                    next_state = STATE_1; // Transition to previous state
                end
                else begin
                    next_state = STATE_2; // Remain in current state
                end
            end
            
            STATE_3: begin
                if (!train_taken && current_state > STATE_0) begin
                    next_state = STATE_2; // Transition to previous state
                end
                else begin
                    next_state = STATE_3; // Remain in current state
                end
            end
        endcase
    end
    
    // Assign the current state to the output
    assign state = current_state;
    
endmodule
