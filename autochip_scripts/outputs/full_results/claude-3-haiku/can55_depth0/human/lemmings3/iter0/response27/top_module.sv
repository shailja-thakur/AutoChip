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
localparam [1:0] WALK_LEFT = 2'b00,
                 WALK_RIGHT = 2'b01,
                 FALL = 2'b10,
                 DIG = 2'b11;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (~ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else if (~ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_RIGHT;
        end
        FALL: begin
            if (ground)
                next_state = state; // Resume previous state
            else
                next_state = FALL;
        end
        DIG: begin
            if (~ground)
                next_state = FALL;
            else
                next_state = DIG;
        end
        default:
            next_state = WALK_LEFT;
    endcase
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALK_LEFT:
            walk_left = 1;
        WALK_RIGHT:
            walk_right = 1;
        FALL:
            aaah = 1;
        DIG:
            digging = 1;
        default:
            ;
    endcase
end

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

endmodule
