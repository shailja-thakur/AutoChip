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

// Define the states
localparam STATE_WALK_LEFT = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALL = 2'b10;

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
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALL: begin
            if (ground) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
            else begin
                next_state = STATE_FALL;
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
        end
        STATE_FALL: begin
            walk_left = walk_left;
            walk_right = walk_right;
            aaah = 1;
        end
        default: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
        end
    endcase
end

endmodule
