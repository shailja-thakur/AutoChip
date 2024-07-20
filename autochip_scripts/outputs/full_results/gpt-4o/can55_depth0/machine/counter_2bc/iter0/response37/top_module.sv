module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;
    
    state_t state, next_state;

    // Asynchronous reset and state transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= S1;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default assignment to hold the state unless a valid transition is made

        if (train_valid) begin
            case (state)
                S0: 
                    if (train_taken) 
                        next_state = S1;
                S1: begin
                    if (train_taken) 
                        next_state = S2;
                    else 
                        next_state = S0;
                end
                S2: begin
                    if (train_taken) 
                        next_state = S3;
                    else 
                        next_state = S1;
                end
                S3: 
                    if (!train_taken) 
                        next_state = S2;
                default: 
                    next_state = S1; // Should not occur, default case
            endcase
        end
    end

    // Output the current state
    assign state = state;

endmodule
