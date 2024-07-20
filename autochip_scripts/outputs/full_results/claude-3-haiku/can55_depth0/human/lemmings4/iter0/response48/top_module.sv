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
parameter STATE_WALKING_LEFT  = 2'b00;
parameter STATE_WALKING_RIGHT = 2'b01;
parameter STATE_FALLING       = 2'b10;
parameter STATE_DIGGING       = 2'b11;

reg [1:0] current_state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALKING_LEFT;
        fall_counter <= 0;
    end
    else begin
        current_state <= next_state;
        if (current_state == STATE_FALLING) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
        STATE_WALKING_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALKING_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALKING_LEFT;
            end
        end
        STATE_WALKING_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALKING_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALKING_RIGHT;
            end
        end
        STATE_FALLING: begin
            aaah = 1;
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = STATE_WALKING_LEFT;
                end
                else begin
                    next_state = current_state;
                end
            end
            else begin
                next_state = STATE_FALLING;
            end
        end
        STATE_DIGGING: begin
            digging = 1;
            if (!ground) begin
                next_state = STATE_FALLING;
            end
            else begin
                next_state = STATE_DIGGING;
            end
        end
        default: begin
            next_state = STATE_WALKING_LEFT;
        end
    endcase

    // Splatter condition
    if (fall_counter >= 20 && !ground) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
    end
end

endmodule
