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
parameter [1:0] WALK_LEFT = 2'b00;
parameter [1:0] WALK_RIGHT = 2'b01;
parameter [1:0] FALLING = 2'b10;
parameter [1:0] DIGGING = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end else begin
        case(state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end else if (ground == 0) begin
                    state <= FALLING;
                    aaah <= 1;
                end else if (dig) begin
                    state <= DIGGING;
                    digging <= 1;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end else if (ground == 0) begin
                    state <= FALLING;
                    aaah <= 1;
                end else if (dig) begin
                    state <= DIGGING;
                    digging <= 1;
                end
            end
            FALLING: begin
                if (ground == 1) begin
                    state <= state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
                    aaah <= 0;
                    walk_left <= state == WALK_LEFT ? 1 : 0;
                    walk_right <= state == WALK_RIGHT ? 1 : 0;
                end
            end
            DIGGING: begin
                if (ground == 0) begin
                    state <= FALLING;
                    aaah <= 1;
                    digging <= 0;
                end
            end
        endcase
    end
end

endmodule
