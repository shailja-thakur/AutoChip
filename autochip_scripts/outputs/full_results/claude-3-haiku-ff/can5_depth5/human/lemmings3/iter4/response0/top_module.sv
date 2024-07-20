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

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALL);
        digging <= (state == DIG);
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1;
            walk_left = 0;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
        end
        FALL: begin
            aaah = 1;
            walk_left = 0;
            walk_right = 0;
            digging = 0;
            if (ground) begin
                next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
            end
        end
        DIG: begin
            digging = 1;
            walk_left = 0;
            walk_right = 0;
            if (!ground) begin
                next_state = FALL;
            end
            else if (!dig) begin
                next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
            end
        end
    endcase
end

endmodule
