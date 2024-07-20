module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else if (train_valid)
            current_state <= next_state;
    end

    // Next State Logic
    always_comb begin
        next_state = current_state; // Default is to stay in the same state
        case (current_state)
            S0: if (train_taken) next_state = S1;
            S1: if (train_taken) next_state = S2;
                else if (!train_taken) next_state = S0;
            S2: if (train_taken) next_state = S3;
                else if (!train_taken) next_state = S1;
            S3: if (!train_taken) next_state = S2;
        endcase
    end

    assign state = current_state;

endmodule
