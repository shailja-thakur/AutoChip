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
localparam [1:0] STATE_WALK_LEFT = 2'd0,
                 STATE_WALK_RIGHT = 2'd1,
                 STATE_FALL = 2'd2,
                 STATE_DIG = 2'd3;

// Define the state variables
reg [1:0] current_state, next_state;
reg [4:0] fall_counter;

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        fall_counter <= 0;
    end
    else begin
        current_state <= next_state;
        if (current_state == STATE_FALL)
            fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end
end

// Next state logic
always @(*) begin
    next_state = current_state;
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
        end
        STATE_FALL: begin
            if (ground)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
        end
        STATE_DIG: begin
            if (!ground)
                next_state = STATE_FALL;
            else if (!dig)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    case (current_state)
        STATE_WALK_LEFT:
            walk_left = 1;
        STATE_WALK_RIGHT:
            walk_right = 1;
        STATE_FALL:
            aaah = 1;
        STATE_DIG:
            digging = 1;
    endcase
    if (fall_counter >= 20 && ground)
        walk_left = 0, walk_right = 0, aaah = 0, digging = 0;
end

endmodule
