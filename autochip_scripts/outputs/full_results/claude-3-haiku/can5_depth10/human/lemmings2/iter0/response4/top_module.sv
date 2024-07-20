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
parameter LEFT = 1'b0, RIGHT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        // When ground is 0, the Lemming will fall and say "aaah!"
        if (~ground) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b1;
        end
        // When ground reappears, the Lemming will resume walking in the same direction
        else if (ground) begin
            aaah <= 1'b0;
            case (state)
                LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            endcase
        end
        // If the Lemming is bumped on the left, it will walk right
        else if (bump_left) begin
            state <= RIGHT;
            walk_left <= 1'b0;
            walk_right <= 1'b1;
        end
        // If the Lemming is bumped on the right, it will walk left
        else if (bump_right) begin
            state <= LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end
    end
end

endmodule
