module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter WALK_LEFT = 1'b0;
parameter WALK_RIGHT = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
                else begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                else begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            end
            default: begin
                state <= WALK_LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
        endcase
    end
end

endmodule
