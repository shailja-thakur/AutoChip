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

    // State transition logic
    always_comb begin
        case(current_state)
            S0: if (train_valid) next_state = (train_taken) ? S1 : S0;
            S1: if (train_valid) next_state = (train_taken) ? S2 : S0;
            S2: if (train_valid) next_state = (train_taken) ? S3 : S1;
            S3: if (train_valid) next_state = (train_taken) ? S3 : S2;
            default: next_state = S1;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // state S1
        else
            state <= current_state;
    end

endmodule
