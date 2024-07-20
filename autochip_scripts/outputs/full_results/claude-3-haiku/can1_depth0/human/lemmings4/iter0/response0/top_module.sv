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
parameter [2:0] STATE_WALK_LEFT = 3'b000,
                STATE_WALK_RIGHT = 3'b001,
                STATE_FALL = 3'b010,
                STATE_DIG = 3'b011,
                STATE_SPLATTER = 3'b100;

reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;

        // Update outputs based on the current state
        case (state)
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
                fall_count <= fall_count + 1;
            end
            STATE_DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
            end
            STATE_SPLATTER: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

always @(*) begin
    // Determine the next state based on the current state and inputs
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) next_state = STATE_WALK_RIGHT;
            else if (ground == 0) next_state = STATE_FALL;
            else if (dig) next_state = STATE_DIG;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) next_state = STATE_WALK_LEFT;
            else if (ground == 0) next_state = STATE_FALL;
            else if (dig) next_state = STATE_DIG;
        end
        STATE_FALL: begin
            if (ground) next_state = STATE_WALK_LEFT; // Resume walking in the previous direction
            else if (fall_count >= 20) next_state = STATE_SPLATTER;
        end
        STATE_DIG: begin
            if (ground == 0) next_state = STATE_FALL;
        end
        STATE_SPLATTER: begin
            // Remain in the splattered state
        end
    endcase
end

endmodule
