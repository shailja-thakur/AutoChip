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

reg [1:0] state;
reg [1:0] next_state;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always @* begin
    next_state = state;
    aaah = 0;
    digging = 0;

    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            if (bump_right && !bump_left) begin
                next_state = WALK_RIGHT;
            end else if (ground == 0) begin
                next_state = FALL;
                aaah = 1;
            end else if (dig) begin
                next_state = DIG;
                digging = 1;
            end
        end

        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            if (bump_left && !bump_right) begin
                next_state = WALK_LEFT;
            end else if (ground == 0) begin
                next_state = FALL;
                aaah = 1;
            end else if (dig) begin
                next_state = DIG;
                digging = 1;
            end
        end

        FALL: begin
            walk_left = 0;
            walk_right = 0;
            if (ground) begin
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end else if (state == DIG) begin
                    next_state = WALK_LEFT;
                end
            end
        end

        DIG: begin
            walk_left = 0;
            walk_right = 0;
            if (ground) begin
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end else if (state == DIG) begin
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

endmodule
