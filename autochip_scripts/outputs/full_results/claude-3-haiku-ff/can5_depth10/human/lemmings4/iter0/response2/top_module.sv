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
parameter STATE_WALK_LEFT = 3'd0;
parameter STATE_WALK_RIGHT = 3'd1;
parameter STATE_FALL = 3'd2;
parameter STATE_DIG = 3'd3;
parameter STATE_SPLATTER = 3'd4;

reg [2:0] state, next_state;
reg [4:0] fall_counter;

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) next_state = STATE_WALK_RIGHT;
            else if (!ground) next_state = STATE_FALL;
            else if (dig) next_state = STATE_DIG;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) next_state = STATE_WALK_LEFT;
            else if (!ground) next_state = STATE_FALL;
            else if (dig) next_state = STATE_DIG;
        end
        STATE_FALL: begin
            if (ground) next_state = STATE_WALK_LEFT; // Resume walking in original direction
            else if (fall_counter == 5'd20) next_state = STATE_SPLATTER;
        end
        STATE_DIG: begin
            if (!ground) next_state = STATE_FALL;
        end
        STATE_SPLATTER: begin
            // Splattered Lemming stays in this state
        end
    endcase
end

// Update state and output logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_counter <= 5'd0;
    end else begin
        state <= next_state;
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_counter <= 5'd0;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_counter <= 5'd0;
            end
            STATE_FALL: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
                fall_counter <= fall_counter + 5'd1;
            end
            STATE_DIG: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b1;
                fall_counter <= 5'd0;
            end
            STATE_SPLATTER: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_counter <= 5'd0;
            end
        endcase
    end
end

endmodule
