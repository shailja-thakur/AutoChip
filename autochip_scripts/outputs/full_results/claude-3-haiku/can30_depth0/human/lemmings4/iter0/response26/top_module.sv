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
typedef enum {LEFT, RIGHT, FALLING} state_t;
state_t state, next_state;

// Counter for tracking the fall duration
reg [4:0] fall_count;

// Asynchronous reset
always @(posedge areset) begin
    state <= LEFT;
    fall_count <= 0;
end

// State update logic
always @(posedge clk) begin
    state <= next_state;
    if (state == FALLING) begin
        fall_count <= fall_count + 1;
    end
    else begin
        fall_count <= 0;
    end
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        LEFT: begin
            if (bump_right) begin
                next_state = RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
        end
        RIGHT: begin
            if (bump_left) begin
                next_state = LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
        end
        FALLING: begin
            if (ground) begin
                if (fall_count >= 20) begin
                    next_state = FALLING; // Splatter
                end
                else begin
                    if (state == LEFT) begin
                        next_state = LEFT;
                    end
                    else begin
                        next_state = RIGHT;
                    end
                end
            end
        end
    endcase
end

// Output logic
assign walk_left = (state == LEFT);
assign walk_right = (state == RIGHT);
assign aaah = (state == FALLING);
assign digging = (state == LEFT || state == RIGHT) && ground && dig;

endmodule
