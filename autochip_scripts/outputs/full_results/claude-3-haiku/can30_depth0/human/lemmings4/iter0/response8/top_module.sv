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
localparam [2:0] WALKING_LEFT = 3'b000,
                 WALKING_RIGHT = 3'b001,
                 FALLING = 3'b010,
                 DIGGING = 3'b011;

// Current state register
reg [2:0] current_state, next_state;

// Fall counter
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALKING_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_counter <= 5'b0;
    end
    else begin
        current_state <= next_state;
        // Update outputs based on the current state
        case (current_state)
            WALKING_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            WALKING_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            FALLING: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
                // Increment fall counter
                fall_counter <= fall_counter + 5'b1;
            end
            DIGGING: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b1;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        WALKING_LEFT: begin
            if (bump_right) begin
                next_state = WALKING_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALKING_LEFT;
            end
        end
        WALKING_RIGHT: begin
            if (bump_left) begin
                next_state = WALKING_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALKING_RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                // Check if the Lemming has fallen for too long
                if (fall_counter >= 5'b10100) begin
                    next_state = WALKING_LEFT; // Splatter
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    fall_counter <= 5'b0;
                end
                else begin
                    next_state = (walk_left) ? WALKING_LEFT : WALKING_RIGHT;
                    aaah <= 1'b0;
                end
            end
            else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;
            end
            else if (!dig) begin
                next_state = (walk_left) ? WALKING_LEFT : WALKING_RIGHT;
            end
            else begin
                next_state = DIGGING;
            end
        end
    endcase
end

endmodule
