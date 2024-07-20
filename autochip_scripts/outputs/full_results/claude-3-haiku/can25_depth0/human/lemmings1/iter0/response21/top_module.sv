module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam STATE_LEFT = 1'b0;
localparam STATE_RIGHT = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (state)
            STATE_LEFT: begin
                if (bump_right) begin
                    state <= STATE_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
                else begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            end
            STATE_RIGHT: begin
                if (bump_left) begin
                    state <= STATE_LEFT;
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
