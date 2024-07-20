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

parameter WALK_LEFT = 1'b1, WALK_RIGHT = 1'b0, FALLING = 2'b10, DIGGING = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;

    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (ground == 1'b0) begin
                next_state = FALLING;
            end
            else if (dig == 1'b1) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (ground == 1'b0) begin
                next_state = FALLING;
            end
            else if (dig == 1'b1) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            aaah = 1'b1;
            if (ground == 1'b1) begin
                if (state == WALK_LEFT) begin
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
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

endmodule
