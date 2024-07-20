module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

reg state;
parameter LEFT = 1'b0, RIGHT = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    state <= RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
                else begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    state <= LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                else begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            end
        endcase
    end
end

endmodule
