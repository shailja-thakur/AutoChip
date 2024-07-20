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

parameter WALK_LEFT = 2'd0;
parameter WALK_RIGHT = 2'd1;
parameter FALL = 2'd2;
parameter DIG = 2'd3;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == FALL) begin
            fall_count <= fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
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
            if (ground) begin
                if (fall_count >= 20) begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end
                else begin
                    if (state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end
                    else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end
        end
        DIG: begin
            digging = 1;
            if (!ground) begin
                next_state = FALL;
            end
        end
    endcase
end

endmodule
