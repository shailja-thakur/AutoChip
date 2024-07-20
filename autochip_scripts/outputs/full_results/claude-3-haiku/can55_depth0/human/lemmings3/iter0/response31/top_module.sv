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

// Define the states of the finite state machine
localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        // Update state based on inputs
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                if (bump_right) begin
                    state <= STATE_WALK_RIGHT;
                end
                else if (~ground) begin
                    state <= STATE_WALK_LEFT;
                    aaah <= 1'b1;
                end
                else if (dig && ground) begin
                    state <= STATE_WALK_LEFT;
                    digging <= 1'b1;
                end
                else begin
                    state <= STATE_WALK_LEFT;
                    digging <= 1'b0;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                if (bump_left) begin
                    state <= STATE_WALK_LEFT;
                end
                else if (~ground) begin
                    state <= STATE_WALK_RIGHT;
                    aaah <= 1'b1;
                end
                else if (dig && ground) begin
                    state <= STATE_WALK_RIGHT;
                    digging <= 1'b1;
                end
                else begin
                    state <= STATE_WALK_RIGHT;
                    digging <= 1'b0;
                end
            end
            default: begin
                state <= STATE_WALK_LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
        endcase
    end
end

endmodule
