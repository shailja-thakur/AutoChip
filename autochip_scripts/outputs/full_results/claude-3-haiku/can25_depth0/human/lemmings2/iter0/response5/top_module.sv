module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

localparam LEFT = 1'b0, RIGHT = 1'b1;
reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == LEFT) ? 1'b1 : 1'b0;
        walk_right <= (state == RIGHT) ? 1'b1 : 1'b0;
        aaah <= (~ground) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        LEFT: begin
            next_state = (bump_right) ? RIGHT : LEFT;
        end
        RIGHT: begin
            next_state = (bump_left) ? LEFT : RIGHT;
        end
        default: next_state = LEFT;
    endcase
end

endmodule
