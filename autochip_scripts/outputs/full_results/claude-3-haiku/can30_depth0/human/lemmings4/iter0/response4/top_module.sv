module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

// Define the states
parameter [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

// State transition logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == FALL)
            fall_count <= fall_count + 1;
        else
            fall_count <= 0;
    end
end

// Next state logic
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig && ground)
                next_state = DIG;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig && ground)
                next_state = DIG;
            else
                next_state = WALK_RIGHT;
        end
        FALL: begin
            if (ground)
                next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
            else
                next_state = FALL;
        end
        DIG: begin
            if (!ground)
                next_state = FALL;
            else
                next_state = DIG;
        end
    endcase
end

// Output logic
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL);
assign digging = (state == DIG);

// Splatter logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else if (fall_count >= 20 && !ground) begin
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
end

endmodule
