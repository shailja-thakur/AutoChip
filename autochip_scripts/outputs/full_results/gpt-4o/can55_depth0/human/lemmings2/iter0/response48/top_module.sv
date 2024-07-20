module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    // State encoding
    typedef enum logic [1:0] {
        LEFT   = 2'b00,
        RIGHT  = 2'b01,
        FALL_L = 2'b10,
        FALL_R = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_L;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_R;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALL_L: begin
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALL_L;
                end
            end
            FALL_R: begin
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALL_R;
                end
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Outputs logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (state)
            LEFT: begin
                walk_left = 1;
            end
            RIGHT: begin
                walk_right = 1;
            end
            FALL_L, FALL_R: begin
                aaah = 1;
            end
        endcase
    end

endmodule
