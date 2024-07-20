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
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        if (ground == 0) begin
            state <= state;
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
        end
        else begin
            if (bump_left && !bump_right) begin
                state <= WALK_RIGHT;
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
            end
            else if (!bump_left && bump_right) begin
                state <= WALK_LEFT;
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
            end
            else if (bump_left && bump_right) begin
                state <= ~state;
                walk_left <= state;
                walk_right <= ~state;
                aaah <= 0;
            end
            else begin
                state <= state;
                walk_left <= state;
                walk_right <= ~state;
                aaah <= 0;
            end
        end
    end
end

endmodule
