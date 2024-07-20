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

// States
localparam STATE_WALK_LEFT = 0,
          STATE_WALK_RIGHT = 1,
          STATE_FALL = 2,
          STATE_DIG = 3;

reg [1:0] state, next_state;

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (ground == 0) begin
                next_state = STATE_FALL;
            end
            else if (bump_right == 1) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (dig == 1) begin
                next_state = STATE_DIG;
            end
        end
        STATE_WALK_RIGHT: begin
            if (ground == 0) begin
                next_state = STATE_FALL;
            end
            else if (bump_left == 1) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (dig == 1) begin
                next_state = STATE_DIG;
            end
        end
        STATE_FALL: begin
            if (ground == 1) begin
                if (walk_left) begin
                    next_state = STATE_WALK_LEFT;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
        end
        STATE_DIG: begin
            if (ground == 0) begin
                next_state = STATE_FALL;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
        end
        STATE_FALL: begin
            aaah = 1;
        end
        STATE_DIG: begin
            digging = 1;
        end
    endcase
end

endmodule
