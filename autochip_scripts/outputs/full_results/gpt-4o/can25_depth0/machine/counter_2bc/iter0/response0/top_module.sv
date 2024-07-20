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

    // Current and next state registers
    state_t current_state, next_state;

    // State transition logic
    always_comb begin
        next_state = current_state; // Default state remains the same
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < S3) begin
                    next_state = current_state + 1;
                end
            end else begin
                if (current_state > S0) begin
                    next_state = current_state - 1;
                end
            end
        end
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign state = current_state;

endmodule
