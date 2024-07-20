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

    // Register to hold the current state
    state_t current_state, next_state;

    // Synchronous state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        next_state = current_state;
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < S3)
                    next_state = current_state + 1;
            end else begin
                if (current_state > S0)
                    next_state = current_state - 1;
            end
        end
    end

    // Output the current state
    assign state = current_state;

endmodule
