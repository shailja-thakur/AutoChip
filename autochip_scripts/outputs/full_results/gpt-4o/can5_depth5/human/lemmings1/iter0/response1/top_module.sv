module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg {LEFT, RIGHT} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            LEFT: if (bump_left) next_state = RIGHT; else next_state = LEFT;
            RIGHT: if (bump_right) next_state = LEFT; else next_state = RIGHT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic (Moore type)
    always @(*) begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end

endmodule
