module top_module(
    input clk,
    input reset,
    output shift_ena);

    typedef enum logic [2:0] {
        B0 = 3'd0,
        B1 = 3'd1,
        B2 = 3'd2,
        B3 = 3'd3,
        Done = 3'd4
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // Output logic
    assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);

endmodule
