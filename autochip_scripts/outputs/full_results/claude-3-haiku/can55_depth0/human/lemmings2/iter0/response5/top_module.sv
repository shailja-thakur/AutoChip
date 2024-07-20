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

localparam WALK_LEFT = 1'b1;
localparam WALK_RIGHT = 1'b0;

reg current_state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    if (ground == 1'b0) begin
        aaah = 1'b1;
        walk_left = current_state;
        walk_right = ~current_state;
    end
    else begin
        aaah = 1'b0;
        if (bump_left == 1'b1) begin
            next_state = WALK_RIGHT;
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
        else if (bump_right == 1'b1) begin
            next_state = WALK_LEFT;
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        else begin
            walk_left = current_state;
            walk_right = ~current_state;
        end
    end
end

endmodule
