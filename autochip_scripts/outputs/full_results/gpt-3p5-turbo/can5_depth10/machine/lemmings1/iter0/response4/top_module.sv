module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    parameter WL = 1;
    parameter WR = 0;

    reg state;

    always @(posedge clk) begin
        if (areset) begin
            state <= WL;
        end else begin
            if (state == WL) begin
                state <= bump_left ? WR : WL;
            end else if (state == WR) begin
                state <= bump_right ? WL : WR;
            end
        end
    end

    always @(posedge clk) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
        end else begin
            if (state == WL) begin
                walk_left <= 1;
                walk_right <= 0;
            end else if (state == WR) begin
                walk_left <= 0;
                walk_right <= 1;
            end
        end
    end

endmodule
