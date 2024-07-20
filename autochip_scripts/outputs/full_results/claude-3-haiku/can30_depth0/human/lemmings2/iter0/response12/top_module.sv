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
localparam STATE_WALK_LEFT  = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALL       = 2'b10;

reg [1:0] state, next_state;

// Update the state on the positive edge of the clock
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

// Combinational logic to update the next state
always @(*) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;

    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end
        end
        STATE_FALL: begin
            aaah = 1;
            if (ground) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
    endcase
end

endmodule
