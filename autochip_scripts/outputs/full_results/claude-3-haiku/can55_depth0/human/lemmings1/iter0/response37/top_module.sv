module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter LEFT = 1'b0, RIGHT = 1'b1;
reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (state)
            LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                if (bump_right) begin
                    state <= RIGHT;
                end
            end
            RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                if (bump_left) begin
                    state <= LEFT;
                end
            end
        endcase
    end
end

endmodule
