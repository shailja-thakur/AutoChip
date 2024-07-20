module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam LEFT = 1'b0;
localparam RIGHT = 1'b1;

reg current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        LEFT: begin
            if (bump_right) begin
                next_state = RIGHT;
            end
        end
        RIGHT: begin
            if (bump_left) begin
                next_state = LEFT;
            end
        end
    endcase
end

always @(*) begin
    case (current_state)
        LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
    endcase
end

endmodule
