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
localparam [1:0] LEFT = 2'b00, RIGHT = 2'b01, FALL = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default values
    next_state = state;
    walk_left = (state == LEFT);
    walk_right = (state == RIGHT);
    aaah = (state == FALL);

    // State transitions
    case (state)
        LEFT: begin
            if (bump_right) begin
                next_state = RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
        end
        RIGHT: begin
            if (bump_left) begin
                next_state = LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
        end
        FALL: begin
            if (ground) begin
                next_state = (walk_left) ? LEFT : RIGHT;
            end
        end
    endcase
end

endmodule
