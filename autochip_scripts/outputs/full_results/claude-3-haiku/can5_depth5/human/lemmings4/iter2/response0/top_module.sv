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

localparam S_WALK_LEFT = 2'b00;
localparam S_WALK_RIGHT = 2'b01;
localparam S_FALL = 2'b10;
localparam S_DIG = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S_WALK_LEFT;
        fall_count <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        if (state == S_FALL)
            fall_count <= fall_count + 1;
        else
            fall_count <= 0;
    end
end

always @(*) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        S_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right)
                next_state = S_WALK_RIGHT;
            else if (!ground)
                next_state = S_FALL;
            else if (dig)
                next_state = S_DIG;
        end
        S_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = S_WALK_LEFT;
            else if (!ground)
                next_state = S_FALL;
            else if (dig)
                next_state = S_DIG;
        end
        S_FALL: begin
            aaah = 1;
            if (ground)
                if (walk_left)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
        end
        S_DIG: begin
            digging = 1;
            if (!ground)
                next_state = S_FALL;
        end
    endcase

    if (fall_count == 20 && ground)
        next_state = S_WALK_LEFT;
end

endmodule
