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

    reg [2:0] state, next_state;
    reg [4:0] fall_count;

    parameter LEFT = 3'b000, RIGHT = 3'b001, FALL_LEFT = 3'b010, FALL_RIGHT = 3'b011, DIG_LEFT = 3'b100, DIG_RIGHT = 3'b101, SPLAT = 3'b110;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (aaah) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 0;
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
                end else if (bump_left) begin
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
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = LEFT;
                    end
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20) begin
                        next_state = SPLAT;
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
            SPLAT: begin
                next_state = SPLAT;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
        digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
    end

endmodule
