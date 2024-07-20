module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);
    // State encoding
    typedef enum logic [2:0] {
        LEFT    = 3'd0,
        RIGHT   = 3'd1,
        FALL_L  = 3'd2,
        FALL_R  = 3'd3,
        DIG_L   = 3'd4,
        DIG_R   = 3'd5,
        SPLAT   = 3'd6
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count; // 5-bit counter to count falling time

    // State transitions
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALL_L || state == FALL_R) begin
                fall_count <= fall_count + 5'd1;
            end else if (ground) begin
                fall_count <= 5'd0;
            end
        end
    end

    // State transition logic
    always @ (*) begin
        next_state = state;
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = RIGHT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = LEFT;
            end
            FALL_L: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLAT;
                    else
                        next_state = LEFT;
                end
            end
            FALL_R: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLAT;
                    else
                        next_state = RIGHT;
                end
            end
            DIG_L: begin
                if (!ground)
                    next_state = FALL_L;
            end
            DIG_R: begin
                if (!ground)
                    next_state = FALL_R;
            end
            SPLAT: next_state = SPLAT;
        endcase
    end

    // Output logic
    always @ (*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (state)
            LEFT: walk_left = 1'b1;
            RIGHT: walk_right = 1'b1;
            FALL_L, FALL_R: aaah = 1'b1;
            DIG_L: digging = 1'b1;
            DIG_R: digging = 1'b1;
            SPLAT: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end
endmodule
