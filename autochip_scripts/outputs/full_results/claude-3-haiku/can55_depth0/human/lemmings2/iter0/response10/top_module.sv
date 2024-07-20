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

reg current_state, next_state;
reg is_falling;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        is_falling <= NOT_FALLING;
    end
    else begin
        current_state <= next_state;
        is_falling <= (ground == 0) ? FALLING : NOT_FALLING;
    end
end

always @(*) begin
    next_state = current_state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;

    if (is_falling) begin
        aaah = 1;
    end
    else begin
        if (bump_left) begin
            next_state = WALK_RIGHT;
        end
        else if (bump_right) begin
            next_state = WALK_LEFT;
        end

        if (current_state == WALK_LEFT) begin
            walk_left = 1;
        end
        else begin
            walk_right = 1;
        end
    end
end

endmodule
