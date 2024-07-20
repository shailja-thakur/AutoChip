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
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        state <= WALK_LEFT;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end
                else if (~ground) begin
                    aaah <= 1'b1;
                    state <= WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                if (bump_left) begin
                    state <= WALK_LEFT;
                end
                else if (~ground) begin
                    aaah <= 1'b1;
                    state <= WALK_RIGHT;
                end
            end
        endcase

        if (ground) begin
            aaah <= 1'b0;
        end
    end
end

endmodule
