module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam STATE_WALKING_LEFT = 1'b0,
          STATE_WALKING_RIGHT = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALKING_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (state)
            STATE_WALKING_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                if (bump_right) begin
                    state <= STATE_WALKING_RIGHT;
                end
            end
            STATE_WALKING_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                if (bump_left) begin
                    state <= STATE_WALKING_LEFT;
                end
            end
        endcase
    end
end

endmodule
