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
localparam STATE_WALK_LEFT  = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALLING    = 2'b10;
localparam STATE_DIGGING    = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default values
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALLING: begin
            aaah = 1;
            if (ground) begin
                if (walk_left) begin
                    next_state = STATE_WALK_LEFT;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            else begin
                next_state = STATE_FALLING;
            end
        end
        STATE_DIGGING: begin
            digging = 1;
            if (!ground) begin
                next_state = STATE_FALLING;
            end
            else begin
                next_state = STATE_DIGGING;
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

endmodule
