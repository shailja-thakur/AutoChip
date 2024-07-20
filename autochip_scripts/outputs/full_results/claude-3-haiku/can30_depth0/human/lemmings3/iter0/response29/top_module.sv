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

// Define the states
localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALL = 2;
localparam STATE_DIG = 3;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALL;
            end else if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else if (dig) begin
                next_state = STATE_DIG;
            end
        end
        STATE_WALK_RIGHT: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALL;
            end else if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (dig) begin
                next_state = STATE_DIG;
            end
        end
        STATE_FALL: begin
            if (ground == 1'b1) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
        STATE_DIG: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALL;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;

    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1'b1;
        end
        STATE_FALL: begin
            aaah = 1'b1;
        end
        STATE_DIG: begin
            digging = 1'b1;
        end
    endcase
end

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end else begin
        state <= next_state;
    end
end

endmodule
