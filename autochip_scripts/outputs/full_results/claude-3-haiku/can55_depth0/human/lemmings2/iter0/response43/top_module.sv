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

// Define the states of the finite state machine
localparam [1:0] STATE_WALK_LEFT = 2'b00,
                 STATE_WALK_RIGHT = 2'b01,
                 STATE_FALL = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;

    // Next state logic
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALL: begin
            aaah = 1;
            if (ground) begin
                if (walk_left) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end else begin
                next_state = STATE_FALL;
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

endmodule
