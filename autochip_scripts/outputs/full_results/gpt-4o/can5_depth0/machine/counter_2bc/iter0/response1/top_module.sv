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
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else if (train_valid) begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;  // Default to current state
        case (current_state)
            S0: if (train_taken) next_state = S1;
            S1: if (train_taken) next_state = S2; else if (!train_taken) next_state = S0;
            S2: if (train_taken) next_state = S3; else if (!train_taken) next_state = S1;
            S3: if (!train_taken) next_state = S2;
            default: next_state = S1; // For safety, reset to S1
        endcase
    end

    // Output logic
    assign state = current_state;

endmodule
