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
localparam STATE_WALK_LEFT = 0,
          STATE_WALK_RIGHT = 1,
          STATE_FALLING = 2,
          STATE_DIGGING = 3;

// State register
reg [1:0] state;

// Fall counter
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    state <= STATE_WALK_RIGHT;
                end
                else if (!ground) begin
                    state <= STATE_FALLING;
                    fall_counter <= 1;
                end
                else if (dig) begin
                    state <= STATE_DIGGING;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    state <= STATE_WALK_LEFT;
                end
                else if (!ground) begin
                    state <= STATE_FALLING;
                    fall_counter <= 1;
                end
                else if (dig) begin
                    state <= STATE_DIGGING;
                end
            end
            STATE_FALLING: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    aaah <= 0;
                end
                else begin
                    fall_counter <= fall_counter + 1;
                    if (fall_counter >= 21) begin
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                end
            end
            STATE_DIGGING: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= STATE_FALLING;
                    fall_counter <= 1;
                end
            end
        endcase
    end
end

endmodule
