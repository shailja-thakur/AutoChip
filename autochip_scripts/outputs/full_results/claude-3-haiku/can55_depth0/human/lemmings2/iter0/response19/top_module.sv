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

// States
parameter STATE_WALK_LEFT  = 2'b00;
parameter STATE_WALK_RIGHT = 2'b01;
parameter STATE_FALLING    = 2'b10;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (ground == 0) begin
                next_state = STATE_FALLING;
            end else if (bump_right == 1) begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (ground == 0) begin
                next_state = STATE_FALLING;
            end else if (bump_left == 1) begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_FALLING: begin
            if (ground == 1) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
        end
        STATE_FALLING: begin
            aaah = 1;
        end
    endcase
end

// State register
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

endmodule
