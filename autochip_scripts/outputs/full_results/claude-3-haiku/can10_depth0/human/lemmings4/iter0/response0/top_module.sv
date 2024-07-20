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
                 FALLING = 2'b10,
                 DIGGING = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_count <= 5'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right <= (state == WALK_RIGHT) ? 1'b1 : 1'b0;
        aaah <= (state == FALLING) ? 1'b1 : 1'b0;
        digging <= (state == DIGGING) ? 1'b1 : 1'b0;
        if (state == FALLING)
            fall_count <= fall_count + 5'b1;
        else
            fall_count <= 5'b0;
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                if (fall_count >= 20) begin
                    next_state = WALK_LEFT;
                    walk_left = 1'b0;
                    walk_right = 1'b0;
                    aaah = 1'b0;
                    digging = 1'b0;
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
            else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = DIGGING;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
