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

reg state;
parameter WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                if (ground == 1'b0) begin
                    state <= WALK_LEFT;
                    aaah <= 1'b1;
                end
                else if (bump_right == 1'b1) begin
                    state <= WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                if (ground == 1'b0) begin
                    state <= WALK_RIGHT;
                    aaah <= 1'b1;
                end
                else if (bump_left == 1'b1) begin
                    state <= WALK_LEFT;
                end
            end
            default: begin
                state <= WALK_LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
            end
        endcase
    end
end

endmodule
