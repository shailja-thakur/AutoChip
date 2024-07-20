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

localparam S_WALK_LEFT = 0, S_WALK_RIGHT = 1, S_FALL = 2, S_DIG = 3, S_SPLATTER = 4;
reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == S_WALK_LEFT);
        walk_right <= (state == S_WALK_RIGHT);
        aaah <= (state == S_FALL);
        digging <= (state == S_DIG);
        if (state == S_FALL) begin
            fall_count <= fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
    end
end

always @(*) begin
    case (state)
        S_WALK_LEFT: begin
            if (bump_right) begin
                next_state = S_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = S_FALL;
            end
            else if (dig) begin
                next_state = S_DIG;
            end
            else begin
                next_state = S_WALK_LEFT;
            end
        end
        S_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = S_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = S_FALL;
            end
            else if (dig) begin
                next_state = S_DIG;
            end
            else begin
                next_state = S_WALK_RIGHT;
            end
        end
        S_FALL: begin
            if (ground) begin
                if (fall_count >= 20) begin
                    next_state = S_SPLATTER;
                end
                else begin
                    if (walk_left) begin
                        next_state = S_WALK_LEFT;
                    end
                    else begin
                        next_state = S_WALK_RIGHT;
                    end
                end
            end
            else begin
                next_state = S_FALL;
            end
        end
        S_DIG: begin
            if (!ground) begin
                next_state = S_FALL;
            end
            else begin
                next_state = S_DIG;
            end
        end
        S_SPLATTER: begin
            next_state = S_SPLATTER;
        end
        default: begin
            next_state = S_WALK_LEFT;
        end
    endcase
end

endmodule
