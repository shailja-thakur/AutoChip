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
localparam [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;

// State register
reg [1:0] state, next_state;

// Fall counter
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_counter <= 5'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALL);
        digging <= (state == DIG);
        if (state == FALL)
            fall_counter <= fall_counter + 1'b1;
        else
            fall_counter <= 5'b0;
    end
end

always @(*) begin
    // Default next state
    next_state = state;

    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig && ground)
                next_state = DIG;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig && ground)
                next_state = DIG;
        end
        FALL: begin
            if (ground)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
        DIG: begin
            if (!ground)
                next_state = FALL;
            else if (!dig)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
    endcase

    // Splatter if falling for too long
    if (fall_counter == 20 && !ground)
        next_state = 2'b00;
end

endmodule
