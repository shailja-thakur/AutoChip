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

localparam [1:0] WALK_LEFT = 2'b00,
                 WALK_RIGHT = 2'b01,
                 FALL = 2'b10,
                 DIG = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
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
            if (ground == 0) begin
                next_state = FALL;
                aaah = 1;
            end
            else if (bump_right == 1) begin
                next_state = WALK_RIGHT;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (ground == 0) begin
                next_state = FALL;
                aaah = 1;
            end
            else if (bump_left == 1) begin
                next_state = WALK_LEFT;
            end
        end
        FALL: begin
            aaah = 1;
            if (ground == 1) begin
                if (walk_left) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
        DIG: begin
            digging = 1;
            if (ground == 0) begin
                next_state = FALL;
                aaah = 1;
            end
        end
    endcase

    if (dig == 1 && ground == 1 && state != FALL) begin
        next_state = DIG;
    end
    else if ((bump_left == 1 || bump_right == 1) && state != FALL) begin
        if (bump_left == 1 && walk_left) begin
            next_state = WALK_RIGHT;
        end
        else if (bump_right == 1 && walk_right) begin
            next_state = WALK_LEFT;
        end
    end
end

endmodule
