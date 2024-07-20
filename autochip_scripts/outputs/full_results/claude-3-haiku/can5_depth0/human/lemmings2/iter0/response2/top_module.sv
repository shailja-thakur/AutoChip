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

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;

    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (~ground) begin
                next_state = STATE_FALLING;
                aaah = 1'b1;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (~ground) begin
                next_state = STATE_FALLING;
                aaah = 1'b1;
            end
        end
        STATE_FALLING: begin
            aaah = 1'b1;
            if (ground) begin
                if (walk_left) begin
                    next_state = STATE_WALK_LEFT;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
        end
    endcase
end

endmodule
