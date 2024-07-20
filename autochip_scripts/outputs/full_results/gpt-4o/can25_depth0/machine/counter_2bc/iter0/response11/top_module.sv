module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define state encoding
    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    // Declare state register
    state_t current_state, next_state;

    // Asynchronous reset or state transition on the clock's rising edge
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1; // Reset to state 1
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic based on inputs
    always_comb begin
        next_state = current_state; // Default to no change

        if (train_valid) begin
            if (train_taken) begin
                if (current_state < STATE_3) begin
                    next_state = current_state + 1;
                end
            end else begin
                if (current_state > STATE_0) begin
                    next_state = current_state - 1;
                end
            end
        end
    end

    // Output the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1; // Reset to state 1
        end else begin
            state <= current_state;
        end
    end

endmodule
