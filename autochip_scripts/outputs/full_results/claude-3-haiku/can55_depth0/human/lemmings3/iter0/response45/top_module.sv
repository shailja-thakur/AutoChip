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

localparam [1:0] WALKING_LEFT = 2'b00,
                 WALKING_RIGHT = 2'b01,
                 FALLING = 2'b10,
                 DIGGING = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= WALKING_LEFT;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALKING_LEFT: begin
            walk_left = 1;
            if (bump_right)
                next_state = WALKING_RIGHT;
            else if (!ground)
                next_state = FALLING;
            else if (dig)
                next_state = DIGGING;
        end
        WALKING_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = WALKING_LEFT;
            else if (!ground)
                next_state = FALLING;
            else if (dig)
                next_state = DIGGING;
        end
        FALLING: begin
            aaah = 1;
            if (ground)
                next_state = state;
        end
        DIGGING: begin
            digging = 1;
            if (!ground)
                next_state = FALLING;
            else if (!dig)
                next_state = state;
        end
    endcase
end

endmodule
