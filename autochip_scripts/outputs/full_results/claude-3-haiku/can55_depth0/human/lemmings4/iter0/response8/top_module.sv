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

// Define the FSM states
localparam [1:0] STATE_WALK_LEFT = 2'b00,
                 STATE_WALK_RIGHT = 2'b01,
                 STATE_FALL = 2'b10,
                 STATE_DIG = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_FALL)
            fall_count <= fall_count + 1;
        else
            fall_count <= 0;
    end
end

always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    // Next state logic
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
            else
                next_state = STATE_WALK_LEFT;
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
            else
                next_state = STATE_WALK_RIGHT;
        end
        STATE_FALL: begin
            aaah = 1;
            if (ground)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            else
                next_state = STATE_FALL;
        end
        STATE_DIG: begin
            digging = 1;
            if (!ground)
                next_state = STATE_FALL;
            else
                next_state = STATE_DIG;
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase

    // Splatter logic
    if (state == STATE_FALL && fall_count == 20 && !ground) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
    end
end

endmodule
