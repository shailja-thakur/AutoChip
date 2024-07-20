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

reg [4:0] fall_counter; // Counter to track the number of cycles the Lemming has been falling

// States for the Finite State Machine
localparam STATE_WALK_LEFT = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALL = 2'b10;
localparam STATE_DIG = 2'b11;

reg [1:0] current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        current_state <= next_state;

        // Update outputs based on the current state
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
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                fall_counter <= fall_counter + 1;
            end
            STATE_DIG: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 0;
                digging <= 1;
                fall_counter <= fall_counter;
            end
        endcase
    end
end

// Update the next state based on the current state and inputs
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALL: begin
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = STATE_WALK_LEFT; // Lemming splatters, reset to walk left
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_counter <= 0;
                end
                else begin
                    next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end
            else begin
                next_state = STATE_FALL;
            end
        end
        STATE_DIG: begin
            if (!ground) begin
                next_state = STATE_FALL;
            end
            else begin
                next_state = STATE_DIG;
            end
        end
    endcase
end

endmodule
