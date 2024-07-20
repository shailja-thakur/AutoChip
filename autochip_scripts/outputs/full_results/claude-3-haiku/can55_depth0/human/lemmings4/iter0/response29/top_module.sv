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

localparam [2:0] WALK_LEFT = 3'd0, WALK_RIGHT = 3'd1, FALLING = 3'd2, DIGGING = 3'd3, SPLATTED = 3'd4;
reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_count <= 5'd0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right <= (state == WALK_RIGHT) ? 1'b1 : 1'b0;
        aaah <= (state == FALLING) ? 1'b1 : 1'b0;
        digging <= (state == DIGGING) ? 1'b1 : 1'b0;
        if (state == FALLING) begin
            fall_count <= fall_count + 1'b1;
        end
        else begin
            fall_count <= 5'd0;
        end
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
                if (fall_count >= 5'd20) begin
                    next_state = SPLATTED;
                end
                else begin
                    if (walk_left) begin
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
        SPLATTED: begin
            next_state = SPLATTED;
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
