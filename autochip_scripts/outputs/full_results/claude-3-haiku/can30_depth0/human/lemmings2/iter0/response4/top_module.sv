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

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        if (ground) begin
            if (state == WALK_LEFT) begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
            else begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end
            aaah <= 1'b0;
        end
        else begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b1;
        end

        if (bump_left) begin
            state <= WALK_RIGHT;
        end
        else if (bump_right) begin
            state <= WALK_LEFT;
        end
    end
end

endmodule
