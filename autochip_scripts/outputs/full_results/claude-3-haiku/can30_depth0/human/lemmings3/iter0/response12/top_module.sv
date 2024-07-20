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
parameter STATE_WALK_LEFT = 0;
parameter STATE_WALK_RIGHT = 1;
parameter STATE_FALL = 2;
parameter STATE_DIG = 3;

// Define the current state
reg [1:0] current_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    current_state <= STATE_WALK_RIGHT;
                end
                else if (!ground) begin
                    current_state <= STATE_FALL;
                end
                else if (dig) begin
                    current_state <= STATE_DIG;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    current_state <= STATE_WALK_LEFT;
                end
                else if (!ground) begin
                    current_state <= STATE_FALL;
                end
                else if (dig) begin
                    current_state <= STATE_DIG;
                end
            end
            STATE_FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    if (walk_left) begin
                        current_state <= STATE_WALK_LEFT;
                    end
                    else begin
                        current_state <= STATE_WALK_RIGHT;
                    end
                end
            end
            STATE_DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    current_state <= STATE_FALL;
                end
                else if (!dig) begin
                    current_state <= STATE_WALK_LEFT;
                end
            end
        endcase
    end
end

endmodule
