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

localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALL = 2;

reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                if (bump_right) begin
                    state <= STATE_WALK_RIGHT;
                end
                else if (!ground) begin
                    state <= STATE_FALL;
                    aaah <= 1;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                if (bump_left) begin
                    state <= STATE_WALK_LEFT;
                end
                else if (!ground) begin
                    state <= STATE_FALL;
                    aaah <= 1;
                end
            end
            STATE_FALL: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1;
                if (ground) begin
                    state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    aaah <= 0;
                end
            end
        endcase
    end
end

endmodule
