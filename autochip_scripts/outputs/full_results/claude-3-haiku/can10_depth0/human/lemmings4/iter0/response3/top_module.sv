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
localparam STATE_SPLATTER = 4;

reg [2:0] state, next_state;
reg [4:0] fall_counter;

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig)
                next_state = STATE_DIG;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig)
                next_state = STATE_DIG;
        end
        STATE_FALL: begin
            if (ground)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
        end
        STATE_DIG: begin
            if (!ground)
                next_state = STATE_FALL;
        end
        STATE_SPLATTER: begin
            // Remain in splatter state
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

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_FALL) begin
            if (fall_counter == 20)
                state <= STATE_SPLATTER;
            else
                fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

endmodule
