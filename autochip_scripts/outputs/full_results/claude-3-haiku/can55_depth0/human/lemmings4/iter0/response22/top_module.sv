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

// States
parameter WALK_LEFT = 2'b00,
          WALK_RIGHT = 2'b01,
          FALL = 2'b10,
          DIG = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == FALL) begin
            if (fall_count < 20)
                fall_count <= fall_count + 1;
            else
                fall_count <= 20;
        end
        else
            fall_count <= 0;
    end
end

// Next state logic
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
            else if (dig & ground)
                next_state = DIG;
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig & ground)
                next_state = DIG;
        end
        FALL: begin
            aaah = 1;
            if (ground) begin
                if (fall_count >= 20)
                    next_state = WALK_LEFT;
                else
                    next_state = state;
            end
        end
        DIG: begin
            digging = 1;
            if (!ground)
                next_state = FALL;
            else if (!dig)
                next_state = state;
        end
    endcase

    if (bump_left & bump_right)
        next_state = (state == WALK_LEFT) ? WALK_RIGHT : WALK_LEFT;
end

endmodule
