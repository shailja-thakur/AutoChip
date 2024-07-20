module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= S1;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default state remains the same
        if (train_valid) begin
            case (current_state)
                S0: if (train_taken) next_state = S1;
                S1: if (train_taken) next_state = S2;
                    else next_state = S0;
                S2: if (train_taken) next_state = S3;
                    else next_state = S1;
                S3: if (~train_taken) next_state = S2;
                default: next_state = S1;
            endcase
        end
    end

    // Assign output
    assign state = current_state;

endmodule
