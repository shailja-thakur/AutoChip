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

reg [1:0] state;
reg [1:0] next_state;

parameter [1:0]
    IDLE = 2'b00,
    LEFT = 2'b01,
    RIGHT = 2'b10;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        state <= next_state;
        case (state)
            IDLE:
                if (bump_left) begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    next_state = RIGHT;
                end else if (bump_right) begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    next_state = LEFT;
                end else if (!ground && !dig) begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    next_state = IDLE;
                end else if (!ground && dig) begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    digging <= 1'b1;
                    next_state = IDLE;
                end else begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    next_state = IDLE;
                end
            LEFT:
                if (bump_right) begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    digging <= 1'b0;
                    next_state = RIGHT;
                end else if (!ground) begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 1'b1;
                    next_state = IDLE;
                end else if (dig) begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    digging <= 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = LEFT;
                end
            RIGHT:
                if (bump_left) begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    digging <= 1'b0;
                    next_state = LEFT;
                end else if (!ground) begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 1'b1;
                    next_state = IDLE;
                end else if (dig) begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    digging <= 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = RIGHT;
                end
        endcase
    end
end

endmodule
