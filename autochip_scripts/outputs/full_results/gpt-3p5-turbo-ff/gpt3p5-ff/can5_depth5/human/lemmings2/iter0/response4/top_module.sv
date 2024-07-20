module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    reg [1:0] state;
    wire falling;

    // State encoding
    parameter [1:0]
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL = 2'b10;

    // Output assignments
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case(state)
                WALK_LEFT: begin
                    if (bump_right && !bump_left)
                        state <= WALK_RIGHT;
                    else if (!bump_right && !bump_left && !ground)
                        state <= FALL;
                end
                WALK_RIGHT: begin
                    if (bump_left && !bump_right)
                        state <= WALK_LEFT;
                    else if (!bump_right && !bump_left && !ground)
                        state <= FALL;
                end
                FALL: begin
                    if (ground)
                        state <= walk_left ? WALK_LEFT : WALK_RIGHT;
                end
            endcase
        end
    end

endmodule
