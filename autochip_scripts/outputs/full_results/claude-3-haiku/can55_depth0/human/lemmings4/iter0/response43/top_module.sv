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

localparam [2:0] WALK_LEFT = 3'd0, WALK_RIGHT = 3'd1, FALL = 3'd2, DIG = 3'd3;
reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == FALL)
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
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig && ground)
                next_state = DIG;
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig && ground)
                next_state = DIG;
        end
        FALL: begin
            aaah = 1;
            if (ground)
                if (walk_left)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
        end
        DIG: begin
            digging = 1;
            if (!ground)
                next_state = FALL;
            else if (!dig)
                if (walk_left)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
        end
    endcase

    if (fall_count == 20 && !ground)
        next_state = 0; // Splatter
end

endmodule
