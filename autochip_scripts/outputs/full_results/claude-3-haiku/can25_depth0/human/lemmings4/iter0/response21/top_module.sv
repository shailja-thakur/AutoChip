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

parameter WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;
reg [1:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_counter <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        if (state == FALL) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            if (ground) begin
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            end
            else if (fall_counter >= 20 && ground) begin
                next_state = WALK_LEFT;
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            else begin
                next_state = FALL;
            end
        end
        DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
            if (!ground) begin
                next_state = FALL;
            end
            else begin
                next_state = DIG;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
