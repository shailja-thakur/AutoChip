module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALLING = 2;
localparam STATE_DIGGING = 3;

reg [1:0] state, next_state;

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (ground == 0) next_state = STATE_FALLING;
            else if (dig && ground) next_state = STATE_DIGGING;
            else if (bump_right) next_state = STATE_WALK_RIGHT;
        end
        STATE_WALK_RIGHT: begin
            if (ground == 0) next_state = STATE_FALLING;
            else if (dig && ground) next_state = STATE_DIGGING;
            else if (bump_left) next_state = STATE_WALK_LEFT;
        end
        STATE_FALLING: begin
            if (ground) next_state = (state == STATE_WALK_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
        end
        STATE_DIGGING: begin
            if (ground == 0) next_state = STATE_FALLING;
        end
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset) state <= STATE_WALK_LEFT;
    else state <= next_state;
end

assign walk_left = (state == STATE_WALK_LEFT);
assign walk_right = (state == STATE_WALK_RIGHT);
assign aaah = (state == STATE_FALLING);
assign digging = (state == STATE_DIGGING);

endmodule
