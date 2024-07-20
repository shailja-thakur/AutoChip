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

localparam WALK_LEFT = 1'b1;
localparam WALK_RIGHT = 1'b0;
localparam FALLING = 1'b1;
localparam NOT_FALLING = 1'b0;

reg state, next_state;
reg falling_state, next_falling_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        falling_state <= NOT_FALLING;
    end
    else begin
        state <= next_state;
        falling_state <= next_falling_state;
    end
end

always @(*) begin
    next_state = state;
    next_falling_state = falling_state;

    if (ground == 1'b0) begin
        next_falling_state = FALLING;
    end
    else begin
        next_falling_state = NOT_FALLING;
    end

    if (falling_state == FALLING) begin
        aaah = 1'b1;
    end
    else begin
        aaah = 1'b0;
    end

    if (bump_left == 1'b1) begin
        next_state = WALK_RIGHT;
    end
    else if (bump_right == 1'b1) begin
        next_state = WALK_LEFT;
    end

    walk_left = (state == WALK_LEFT);
    walk_right = (state == WALK_RIGHT);
end

endmodule
