module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;

                if (bump_right) begin
                    state <= STATE_WALK_RIGHT;
                end
                else if (!ground) begin
                    aaah <= 1'b1;
                    state <= STATE_WALK_LEFT;
                end
                else if (dig && ground) begin
                    digging <= 1'b1;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;

                if (bump_left) begin
                    state <= STATE_WALK_LEFT;
                end
                else if (!ground) begin
                    aaah <= 1'b1;
                    state <= STATE_WALK_RIGHT;
                end
                else if (dig && ground) begin
                    digging <= 1'b1;
                end
            end
        endcase

        if (ground && !aaah) begin
            digging <= 1'b0;
        end
        else if (!ground && digging) begin
            digging <= 1'b0;
            aaah <= 1'b1;
        end
    end
end

endmodule
