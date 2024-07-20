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

parameter WALK_LEFT  = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING    = 2'b10;
parameter DIGGING    = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            walk_left  = 1'b1;
            walk_right = 1'b0;
            aaah       = 1'b0;
            digging    = 1'b0;
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALLING;
            else if (dig) next_state = DIGGING;
        end
        WALK_RIGHT: begin
            walk_left  = 1'b0;
            walk_right = 1'b1;
            aaah       = 1'b0;
            digging    = 1'b0;
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALLING;
            else if (dig) next_state = DIGGING;
        end
        FALLING: begin
            walk_left  = 1'b0;
            walk_right = 1'b0;
            aaah       = 1'b1;
            digging    = 1'b0;
            fall_count = fall_count + 1'b1;
            if (ground) begin
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                fall_count = 0;
            end
            else if (fall_count == 5'b10101) next_state = 2'b00; // Splatter
        end
        DIGGING: begin
            walk_left  = 1'b0;
            walk_right = 1'b0;
            aaah       = 1'b0;
            digging    = 1'b1;
            if (!ground) next_state = FALLING;
            else if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state      <= WALK_LEFT;
        walk_left  <= 1'b1;
        walk_right <= 1'b0;
        aaah       <= 1'b0;
        digging    <= 1'b0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
    end
end

endmodule
