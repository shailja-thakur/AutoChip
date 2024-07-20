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
        LEFT = 3'd0,
        RIGHT = 3'd1,
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3,
        DIG_LEFT = 3'd4,
        DIG_RIGHT = 3'd5,
        SPLATTER = 3'd6
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_timer;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_timer <= 0;
        end else begin
            state <= next_state;
            if(state == FALL_LEFT || state == FALL_RIGHT) 
                fall_timer <= (fall_timer == 21)  ? 0 : fall_timer + 1;
            else
                fall_timer <= 0;
        end
    end

    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end 
                else if (dig) begin
                    next_state = DIG_LEFT;
                end 
                else if (bump_left || bump_right) begin
                    next_state = RIGHT;
                end 
                else begin
                    walk_left = 1;
                    next_state = LEFT;
                end
            end

            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end 
                else if (dig) begin
                    next_state = DIG_RIGHT;
                end 
                else if (bump_left || bump_right) begin
                    next_state = LEFT;
                end 
                else begin
                    walk_right = 1;
                    next_state = RIGHT;
                end
            end

            FALL_LEFT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_timer <= 20) begin
                        next_state = LEFT;
                    end else begin
                        next_state = SPLATTER;
                    end
                end 
                else begin
                    next_state = FALL_LEFT;
                end
            end

            FALL_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_timer <= 20) begin
                        next_state = RIGHT;
                    end else begin
                        next_state = SPLATTER;
                    end
                end 
                else begin
                    next_state = FALL_RIGHT;
                end
            end

            DIG_LEFT: begin
                digging = 1;
                if (!ground) begin
                    next_state = FALL_LEFT;
                end 
                else begin
                    next_state = DIG_LEFT;
                end
            end

            DIG_RIGHT: begin
                digging = 1;
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end 
                else begin
                    next_state = DIG_RIGHT;
                end
            end

            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                next_state = SPLATTER;
            end

            default: next_state = state;

        endcase
    end

endmodule
