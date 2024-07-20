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
                 STATE_FALL = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
        end
        STATE_FALL: begin
            walk_left = state == STATE_WALK_LEFT;
            walk_right = state == STATE_WALK_RIGHT;
            aaah = 1'b1;
            if (ground) begin
                next_state = state;
            end
        end
    endcase
end

endmodule
