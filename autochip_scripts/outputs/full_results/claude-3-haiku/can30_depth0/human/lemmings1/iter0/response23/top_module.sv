module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam LEFT = 1'b0, RIGHT = 1'b1;
reg current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        current_state <= LEFT;
    else
        current_state <= next_state;
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            if (bump_right)
                next_state = RIGHT;
        end
        RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            if (bump_left)
                next_state = LEFT;
        end
    endcase
end

endmodule
