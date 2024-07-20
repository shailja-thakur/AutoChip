module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam LEFT = 1'b0, RIGHT = 1'b1;
reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            if (bump_right) begin
                next_state = RIGHT;
            end
        end
        RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = LEFT;
            end
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
        end
    endcase
end

endmodule
