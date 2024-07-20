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

localparam [1:0] STATE_WALK_LEFT = 2'b00,
                 STATE_WALK_RIGHT = 2'b01,
                 STATE_FALLING = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
                walk_left = 0;
                walk_right = 1;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
                aaah = 1;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
                walk_left = 1;
                walk_right = 0;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
                aaah = 1;
            end
        end
        STATE_FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            if (ground) begin
                if (state == STATE_WALK_LEFT) begin
                    next_state = STATE_WALK_LEFT;
                    walk_left = 1;
                    walk_right = 0;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                    walk_left = 0;
                    walk_right = 1;
                end
                aaah = 0;
            end
        end
    endcase
end

endmodule
