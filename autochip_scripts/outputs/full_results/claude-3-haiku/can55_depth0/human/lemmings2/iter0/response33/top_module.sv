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

reg [1:0] current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;

    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else if (!ground) begin
                next_state = STATE_FALLING;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (!ground) begin
                next_state = STATE_FALLING;
            end
        end
        STATE_FALLING: begin
            aaah = 1;
            if (ground) begin
                if (walk_left) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

endmodule
