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

    reg [19:0] fall_counter;
    reg [2:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_left || bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = LEFT;
                    end
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = RIGHT;
                    end
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else begin
                    next_state = DIG_LEFT;
                end
            end
            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else begin
                    next_state = DIG_RIGHT;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == FALL_LEFT || state == FALL_RIGHT);
        digging = (state == DIG_LEFT || state == DIG_RIGHT);
    end
endmodule
