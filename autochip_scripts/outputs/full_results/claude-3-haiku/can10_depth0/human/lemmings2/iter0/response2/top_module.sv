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

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;

    case (current_state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (~ground) begin
                aaah = 1'b1;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (~ground) begin
                aaah = 1'b1;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase

    if (~ground) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
    end
end

endmodule
