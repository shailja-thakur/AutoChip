module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg [1:0] {
        S_LEFT  = 2'b01,
        S_RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @* begin
        case (state)
            S_LEFT: begin
                if (bump_left) next_state = S_RIGHT;
                else next_state = S_LEFT;
            end

            S_RIGHT: begin
                if (bump_right) next_state = S_LEFT;
                else next_state = S_RIGHT;
            end

            default: next_state = S_LEFT; // Default to S_LEFT
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @* begin
        case (state)
            S_LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            S_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end

endmodule
