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
parameter WALK_LEFT = 0, WALK_RIGHT = 1, FALL = 2, DIG = 3, SPLATTER = 4;

// State variables
reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        fall_count <= (state == FALL) ? fall_count + 1 : 0;
    end
end

always @(*) begin
    // Default values
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_RIGHT;
        end
        FALL: begin
            aaah = 1;
            if (ground)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else if (fall_count == 20)
                next_state = SPLATTER;
            else
                next_state = FALL;
        end
        DIG: begin
            digging = 1;
            if (!ground)
                next_state = FALL;
            else
                next_state = DIG;
        end
        SPLATTER: begin
            // Do nothing, stay in SPLATTER state
            next_state = SPLATTER;
        end
    endcase
end

endmodule
