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

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= WALK_LEFT;
        walk_right <= WALK_RIGHT;
        aaah <= 1'b0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= WALK_LEFT;
                walk_right <= WALK_RIGHT;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end
                else if (!ground) begin
                    state <= WALK_LEFT;
                    aaah <= 1'b1;
                end
                else begin
                    aaah <= 1'b0;
                end
            end
            WALK_RIGHT: begin
                walk_left <= WALK_RIGHT;
                walk_right <= WALK_LEFT;
                if (bump_left) begin
                    state <= WALK_LEFT;
                end
                else if (!ground) begin
                    state <= WALK_RIGHT;
                    aaah <= 1'b1;
                end
                else begin
                    aaah <= 1'b0;
                end
            end
            default: begin
                state <= WALK_LEFT;
                walk_left <= WALK_LEFT;
                walk_right <= WALK_RIGHT;
                aaah <= 1'b0;
            end
        endcase
    end
end

endmodule
