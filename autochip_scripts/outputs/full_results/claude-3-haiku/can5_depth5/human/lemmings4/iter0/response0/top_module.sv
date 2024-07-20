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

localparam S_WALK_LEFT = 0, S_WALK_RIGHT = 1, S_FALL = 2, S_DIG = 3, S_SPLATTER = 4;
reg [2:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == S_WALK_LEFT);
        walk_right <= (state == S_WALK_RIGHT);
        aaah <= (state == S_FALL);
        digging <= (state == S_DIG);
        if (state == S_FALL)
            fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        S_WALK_LEFT: begin
            if (bump_right)
                next_state = S_WALK_RIGHT;
            else if (!ground)
                next_state = S_FALL;
            else if (dig && ground)
                next_state = S_DIG;
        end
        S_WALK_RIGHT: begin
            if (bump_left)
                next_state = S_WALK_LEFT;
            else if (!ground)
                next_state = S_FALL;
            else if (dig && ground)
                next_state = S_DIG;
        end
        S_FALL: begin
            if (ground)
                next_state = (walk_left) ? S_WALK_LEFT : S_WALK_RIGHT;
            else if (fall_counter >= 20)
                next_state = S_SPLATTER;
        end
        S_DIG: begin
            if (!ground)
                next_state = S_FALL;
        end
        S_SPLATTER: begin
            // Stay in splatter state
        end
    endcase
end

endmodule
