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

reg [5:0] fall_counter;

// Define the states
localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALL = 2;
localparam STATE_DIG = 3;
localparam STATE_SPLATTER = 4;

reg [2:0] current_state, next_state;

// State transition logic
always @(*) begin
    next_state = current_state;
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
        end
        STATE_FALL: begin
            if (ground)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            else if (fall_counter == 20)
                next_state = STATE_SPLATTER;
        end
        STATE_DIG: begin
            if (!ground)
                next_state = STATE_FALL;
        end
        STATE_SPLATTER: begin
            // Stay in the splatter state
        end
    endcase
end

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end else begin
        current_state <= next_state;
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_counter <= 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                fall_counter <= 0;
            end
            STATE_FALL: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1;
                digging <= 0;
                fall_counter <= fall_counter + 1;
            end
            STATE_DIG: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 0;
                digging <= 1;
                fall_counter <= 0;
            end
            STATE_SPLATTER: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_counter <= 0;
            end
        endcase
    end
end

endmodule
