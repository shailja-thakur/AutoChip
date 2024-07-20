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

localparam [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (~ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left)
                next_state = WALK_LEFT;
            else if (~ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_RIGHT;
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            if (ground)
                next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
            else
                next_state = FALL;
        end
        DIG: begin
            walk_left = state == WALK_LEFT;
            walk_right = state == WALK_RIGHT;
            aaah = 0;
            digging = 1;
            if (~ground)
                next_state = FALL;
            else
                next_state = DIG;
        end
        default: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
