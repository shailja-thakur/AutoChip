module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state register
    logic [1:0] current_state, next_state;

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;  // Reset to state 1
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to remain in current state
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

    // Output current state
    assign state = current_state;

endmodule
