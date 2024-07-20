module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding: 00 for state 0, 01 for state 1, 10 for state 2, and 11 for state 3
    typedef enum logic [1:0] {
        STATE_0 = 2'd0,
        STATE_1 = 2'd1,
        STATE_2 = 2'd2,
        STATE_3 = 2'd3
    } state_t;

    state_t next_state;

    // State update on the rising edge of the clock or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1; // Reset to state 1
        end else if (train_valid) begin
            state <= next_state; // Update state based on next_state
        end
    end

    // State transition logic
    always_comb begin
        next_state = state; // Default to remain in current state
        case (state)
            STATE_0: if (train_taken) next_state = STATE_1;
            STATE_1: if (train_taken) next_state = STATE_2;
                     else next_state = STATE_0;
            STATE_2: if (train_taken) next_state = STATE_3;
                     else next_state = STATE_1;
            STATE_3: if (!train_taken) next_state = STATE_2;
            default: next_state = STATE_1; // Should never occur, default state 
        endcase
    end

endmodule
