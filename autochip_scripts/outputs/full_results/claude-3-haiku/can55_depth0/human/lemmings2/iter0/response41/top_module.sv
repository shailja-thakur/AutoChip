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
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        current_state <= next_state;
        walk_left <= (current_state == WALK_LEFT) ? 1 : 0;
        walk_right <= (current_state == WALK_RIGHT) ? 1 : 0;
        aaah <= (ground == 0) ? 1 : 0;
    end
end

always @(*) begin
    case (current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (bump_left) begin
                next_state = WALK_RIGHT;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (bump_right) begin
                next_state = WALK_LEFT;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
