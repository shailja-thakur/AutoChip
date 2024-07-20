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
localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALL = 2;
localparam STATE_DIG = 3;

// Declare the current state register
reg [1:0] current_state;

// Asynchronous reset
always @(posedge areset) begin
    current_state <= STATE_WALK_LEFT;
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
    digging <= 0;
end

// State transition logic
always @(posedge clk) begin
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
            walk_left <= walk_left;
            walk_right <= walk_right;
            aaah <= 1;
            digging <= 0;
            if (ground) begin
                current_state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
        STATE_DIG: begin
            walk_left <= walk_left;
            walk_right <= walk_right;
            aaah <= 0;
            digging <= 1;
            if (!ground) begin
                current_state <= STATE_FALL;
            end
            else if (!dig) begin
                current_state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
    endcase
end

endmodule
