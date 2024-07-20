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

// Define the states
localparam STATE_WALK_LEFT = 0, STATE_WALK_RIGHT = 1, STATE_FALL = 2, STATE_DIG = 3;

// State register
reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (ground == 0) begin
                    state <= STATE_FALL;
                    aaah <= 1;
                end
                else if (bump_right == 1) begin
                    state <= STATE_WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
                else if (dig == 1) begin
                    state <= STATE_DIG;
                    digging <= 1;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (ground == 0) begin
                    state <= STATE_FALL;
                    aaah <= 1;
                end
                else if (bump_left == 1) begin
                    state <= STATE_WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
                else if (dig == 1) begin
                    state <= STATE_DIG;
                    digging <= 1;
                end
            end
            STATE_FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground == 1) begin
                    state <= (walk_left == 1) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    aaah <= 0;
                end
            end
            STATE_DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (ground == 0) begin
                    state <= STATE_FALL;
                    aaah <= 1;
                end
                else if (dig == 0) begin
                    state <= (walk_left == 1) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    digging <= 0;
                end
            end
            default: begin
                state <= STATE_WALK_LEFT;
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
