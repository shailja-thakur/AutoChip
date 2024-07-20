module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State Declaration
    typedef enum logic [1:0] {
        WL = 2'b00,
        WR = 2'b01
    } state_t;

    state_t state, next_state;

    // Combinational logic for next state
    always_comb begin
        case(state)
            WL: begin
                if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
            end
            WR: begin
                if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            end
            default: next_state = WL;
        endcase
    end

    // Sequential logic to update state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end

    // Output logic based on the current state
    always_comb begin
        case(state)
            WL: begin
                walk_left = 1;
                walk_right = 0;
            end
            WR: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
            end
        endcase
    end

endmodule
