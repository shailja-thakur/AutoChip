module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Define states
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;

    // State register
    logic [1:0] current_state;
    
    // Declare next state variable
    logic [1:0] next_state;
    
    // Asynchronous reset to state 1
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_1;
        else
            current_state <= next_state;
    end
    
    // Assign next state based on current state and inputs
    always_comb begin
        case (current_state)
            STATE_0: begin
                if (train_valid && train_taken)
                    next_state = STATE_1;
                else
                    next_state = STATE_0;
            end
            STATE_1: begin
                if (train_valid && train_taken && current_state < STATE_3)
                    next_state = current_state + 1;
                else if (train_valid && !train_taken && current_state > STATE_0)
                    next_state = current_state - 1;
                else
                    next_state = current_state;
            end
            STATE_2: begin
                if (train_valid && train_taken && current_state < STATE_3)
                    next_state = current_state + 1;
                else if (train_valid && !train_taken && current_state > STATE_0)
                    next_state = current_state - 1;
                else
                    next_state = current_state;
            end
            STATE_3: begin
                if (train_valid && !train_taken && current_state > STATE_0)
                    next_state = current_state - 1;
                else
                    next_state = current_state;
            end
        endcase
    end
    
    // Assign current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_1;
        else
            state <= current_state;
    end
endmodule
