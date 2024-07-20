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

localparam STATE_WALK_LEFT = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALLING = 2'b10;
localparam STATE_DIGGING = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_count <= 5'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (next_state == STATE_WALK_LEFT);
        walk_right <= (next_state == STATE_WALK_RIGHT);
        aaah <= (next_state == STATE_FALLING);
        digging <= (next_state == STATE_DIGGING);
        if (next_state == STATE_FALLING) begin
            fall_count <= fall_count + 1'b1;
        end
        else begin
            fall_count <= 5'b0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALLING;
            end
            else if (bump_right == 1'b1) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (dig == 1'b1) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_WALK_RIGHT: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALLING;
            end
            else if (bump_left == 1'b1) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (dig == 1'b1) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_FALLING: begin
            if (ground == 1'b1) begin
                if (fall_count >= 20) begin
                    next_state = STATE_WALK_LEFT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                end
                else begin
                    next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end
        end
        STATE_DIGGING: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALLING;
            end
            else if (dig == 1'b0) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
    endcase
end

endmodule
