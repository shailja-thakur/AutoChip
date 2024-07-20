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

    typedef enum reg [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLAT
    } state_t;

    reg [2:0] state, next_state;
    reg [4:0] fall_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (fall_count >= 20)
                    next_state = SPLAT;
                else if (ground)
                    next_state = (state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
                else
                    next_state = state;
            end
            DIG_LEFT, DIG_RIGHT: begin
                if (!ground)
                    next_state = (state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
                else
                    next_state = state;
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
            end
            WALK_RIGHT: begin
                walk_right = 1;
            end
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1;
            end
            DIG_LEFT: begin
                digging = 1;
            end
            DIG_RIGHT: begin
                digging = 1;
			end
			SPLAT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
        endcase
    end
endmodule
