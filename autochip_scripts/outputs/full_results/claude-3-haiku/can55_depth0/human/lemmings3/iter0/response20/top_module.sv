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

localparam [2:0] WALK_LEFT = 3'd0,
                 WALK_RIGHT = 3'd1,
                 FALLING = 3'd2,
                 DIGGING = 3'd3;

reg [2:0] state, next_state;

always @(*) begin
    next_state = state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;

    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            if (ground == 1'b0) begin
                next_state = FALLING;
            end
            else if (bump_right == 1'b1) begin
                next_state = WALK_RIGHT;
            end
            else if (dig == 1'b1) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1'b1;
            if (ground == 1'b0) begin
                next_state = FALLING;
            end
            else if (bump_left == 1'b1) begin
                next_state = WALK_LEFT;
            end
            else if (dig == 1'b1) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            aaah = 1'b1;
            if (ground == 1'b1) begin
                if (walk_left) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
        DIGGING: begin
            digging = 1'b1;
            if (ground == 1'b0) begin
                next_state = FALLING;
            end
            else if (dig == 1'b0) begin
                if (walk_left) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

endmodule
