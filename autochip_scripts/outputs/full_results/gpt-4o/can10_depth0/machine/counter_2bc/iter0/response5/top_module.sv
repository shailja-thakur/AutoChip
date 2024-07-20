module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition based on the inputs
    always_comb begin
        next_state = current_state;  // default to no state change
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < STATE_3) begin
                    next_state = current_state + 1;  // move to next state
                end
            end else begin
                if (current_state > STATE_0) begin
                    next_state = current_state - 1;  // move to previous state
                end
            end
        end
    end

    // State update logic with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;  // Asynchronous reset to state 1
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign state = current_state;

endmodule
