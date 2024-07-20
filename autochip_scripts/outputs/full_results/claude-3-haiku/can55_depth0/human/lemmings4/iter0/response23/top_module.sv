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
localparam [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALLING = 2'b10, DIGGING = 2'b11;

// Declare the current and next state registers
reg [1:0] current_state, next_state;

// Declare the fall counter
reg [4:0] fall_counter;

// Asynchronous reset
always @(posedge areset) begin
    current_state <= WALK_LEFT;
    walk_left <= 1'b1;
    walk_right <= 1'b0;
    aaah <= 1'b0;
    digging <= 1'b0;
    fall_counter <= 5'b0;
end

// State transition logic
always @(current_state, bump_left, bump_right, ground, dig) begin
    next_state = current_state;
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            if (!ground) begin
                next_state = FALLING;
            end
            if (dig && ground) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            if (!ground) begin
                next_state = FALLING;
            end
            if (dig && ground) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b1;
            fall_counter = fall_counter + 1'b1;
            if (ground) begin
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                aaah = 1'b0;
            end
            if (fall_counter == 20) begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        end
        DIGGING: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            digging = 1'b1;
            if (!ground) begin
                next_state = FALLING;
            end
        end
    endcase
end

// State update logic
always @(posedge clk) begin
    current_state <= next_state;
end

endmodule
