module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam LEFT = 1'b0, RIGHT = 1'b1;
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end
    else begin
        case (state)
            LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                if (bump_right) begin
                    state <= RIGHT;
                end
            end
            RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                if (bump_left) begin
                    state <= LEFT;
                end
            end
            default: begin
                state <= LEFT;
                walk_left <= 1;
                walk_right <= 0;
            end
        endcase
    end
end

endmodule
