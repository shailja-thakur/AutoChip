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

localparam LEFT = 1'b1;
localparam RIGHT = 1'b0;

reg current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        current_state <= next_state;
        walk_left <= (current_state == LEFT) ? 1'b1 : 1'b0;
        walk_right <= (current_state == RIGHT) ? 1'b1 : 1'b0;
        aaah <= (ground == 1'b0) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (current_state)
        LEFT: begin
            if (bump_right == 1'b1) begin
                next_state = RIGHT;
            end
            else if (ground == 1'b0) begin
                next_state = current_state;
            end
            else begin
                next_state = LEFT;
            end
        end
        RIGHT: begin
            if (bump_left == 1'b1) begin
                next_state = LEFT;
            end
            else if (ground == 1'b0) begin
                next_state = current_state;
            end
            else begin
                next_state = RIGHT;
            end
        end
        default: begin
            next_state = LEFT;
        end
    endcase
end

endmodule
