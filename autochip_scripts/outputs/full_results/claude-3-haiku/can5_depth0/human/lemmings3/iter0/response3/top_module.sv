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

// Define the state parameters
parameter STATE_WALK_LEFT = 2'b00;
parameter STATE_WALK_RIGHT = 2'b01;
parameter STATE_FALL = 2'b10;
parameter STATE_DIG = 2'b11;

// Internal state register
reg [1:0] state;

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
                else if (~ground) begin
                    state <= STATE_FALL;
                end
                else if (dig) begin
                    state <= STATE_DIG;
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
                else if (~ground) begin
                    state <= STATE_FALL;
                end
                else if (dig) begin
                    state <= STATE_DIG;
                end
            end
            STATE_FALL: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1'b1;
                digging <= 1'b0;
                if (ground) begin
                    state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end
            STATE_DIG: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1'b0;
                digging <= 1'b1;
                if (~ground) begin
                    state <= STATE_FALL;
                end
                else if (~dig) begin
                    state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end
        endcase
    end
end

endmodule
