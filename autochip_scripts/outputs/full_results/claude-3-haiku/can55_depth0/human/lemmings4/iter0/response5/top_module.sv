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
parameter STATE_WALK_LEFT = 2'b00;
parameter STATE_WALK_RIGHT = 2'b01;
parameter STATE_FALL = 2'b10;
parameter STATE_DIG = 2'b11;

reg [1:0] state, next_state;
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
            if (ground) next_state = state;
        end
        STATE_DIG: begin
            if (!ground) next_state = STATE_FALL;
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    case (state)
        STATE_WALK_LEFT: walk_left = 1;
        STATE_WALK_RIGHT: walk_right = 1;
        STATE_FALL: aaah = 1;
        STATE_DIG: digging = 1;
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_FALL) begin
            if (ground) fall_counter <= 0;
            else fall_counter <= fall_counter + 1;
        end
        else if (state == STATE_DIG && !ground) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

// Splatter logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else if (fall_counter >= 20 && ground) begin
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
end

endmodule
