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

reg state, next_state;
localparam WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT) ? 1 : 0;
        walk_right <= (state == WALK_RIGHT) ? 1 : 0;
    end
end

always @(*) begin
    aaah = 0;
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                aaah = 1;
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                aaah = 1;
                next_state = WALK_RIGHT;
            end
        end
    endcase
end

endmodule
