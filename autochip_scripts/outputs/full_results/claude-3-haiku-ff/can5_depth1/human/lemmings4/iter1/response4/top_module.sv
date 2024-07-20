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
                 STATE_FALLING = 2'b10,
                 STATE_DIGGING = 2'b11;

reg [1:0] current_state, next_state;
reg [4:0] fall_counter;

// State transition logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
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

// Next state logic
always @(*) begin
    next_state = current_state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_FALLING: begin
            aaah = 1;
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = STATE_WALK_LEFT;
                    fall_counter = 0;
                end
                else begin
                    if (bump_left) begin
                        next_state = STATE_WALK_RIGHT;
                    end
                    else if (bump_right) begin
                        next_state = STATE_WALK_LEFT;
                    end
                    else begin
                        next_state = current_state;
                    end
                end
            end
        end
        STATE_DIGGING: begin
            digging = 1;
            if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (!dig) begin
                next_state = current_state;
            end
        end
    endcase
end

endmodule
