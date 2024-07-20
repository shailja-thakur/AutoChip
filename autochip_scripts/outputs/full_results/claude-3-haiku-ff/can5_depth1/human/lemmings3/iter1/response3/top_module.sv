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
localparam [1:0] STATE_WALK_LEFT = 2'b00,
                 STATE_WALK_RIGHT = 2'b01,
                 STATE_FALL = 2'b10,
                 STATE_DIG = 2'b11;

reg [1:0] state, next_state;

// Combinational logic for next state
always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) next_state = STATE_WALK_RIGHT;
            else if (!ground) next_state = STATE_FALL;
            else if (dig && ground) next_state = STATE_DIG;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) next_state = STATE_WALK_LEFT;
            else if (!ground) next_state = STATE_FALL;
            else if (dig && ground) next_state = STATE_DIG;
        end
        STATE_FALL: begin
            if (ground) next_state = STATE_WALK_LEFT;
        end
        STATE_DIG: begin
            if (!ground) next_state = STATE_FALL;
        end
    endcase
end

// Sequential logic for state update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        state <= next_state;
        case (next_state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
            end
            STATE_FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
            end
            STATE_DIG: begin
                walk_left <= state == STATE_WALK_LEFT;
                walk_right <= state == STATE_WALK_RIGHT;
                aaah <= 0;
                digging <= 1;
            end
        endcase
    end
end

endmodule
