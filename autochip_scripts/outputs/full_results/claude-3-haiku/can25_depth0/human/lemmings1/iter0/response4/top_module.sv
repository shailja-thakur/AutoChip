module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

parameter LEFT = 1'b0, RIGHT = 1'b1;
reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= LEFT;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        LEFT: begin
            if (bump_left)
                next_state = RIGHT;
            else
                next_state = LEFT;
        end
        RIGHT: begin
            if (bump_right)
                next_state = LEFT;
            else
                next_state = RIGHT;
        end
        default:
            next_state = LEFT;
    endcase
end

assign walk_left = (state == LEFT);
assign walk_right = (state == RIGHT);

endmodule
