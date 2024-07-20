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

localparam WALK_LEFT = 2'd0;
localparam WALK_RIGHT = 2'd1;
localparam FALLING = 2'd2;
localparam DIGGING = 2'd3;

reg [1:0] state, next_state;
reg [4:0] fall_timer;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_timer <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALLING);
        digging <= (state == DIGGING);
        if (state == FALLING) begin
            fall_timer <= fall_timer + 1;
        end
        else begin
            fall_timer <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            if (ground) begin
                if (fall_timer >= 20) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;
            end
        end
    endcase
end

endmodule
