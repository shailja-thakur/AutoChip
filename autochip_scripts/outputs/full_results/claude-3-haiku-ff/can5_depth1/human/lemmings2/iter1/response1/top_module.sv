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

localparam WALK_LEFT = 1'b0;
localparam WALK_RIGHT = 1'b1;
localparam FALLING = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end
                else if (!ground) begin
                    state <= FALLING;
                    aaah <= 1;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                if (bump_left) begin
                    state <= WALK_LEFT;
                end
                else if (!ground) begin
                    state <= FALLING;
                    aaah <= 1;
                end
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                if (ground) begin
                    if (state == WALK_LEFT) begin
                        state <= WALK_LEFT;
                    end
                    else begin
                        state <= WALK_RIGHT;
                    end
                    aaah <= 0;
                end
            end
        endcase
    end
end

endmodule
