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

// Define the states
parameter WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;

// State register
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
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
                    state <= WALK_RIGHT; // Fall and switch to walking right
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
                    state <= WALK_LEFT; // Fall and switch to walking left
                end
            end
        endcase
    end
end

endmodule
