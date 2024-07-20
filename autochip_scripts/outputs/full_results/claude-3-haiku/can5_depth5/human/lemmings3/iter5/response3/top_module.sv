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

// Define the state parameters
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter DIGGING = 2'b11;

// Define the current state register
reg [1:0] current_state, next_state;

// Asynchronous reset
always @(posedge areset) begin
    current_state <= WALK_LEFT;
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
    digging <= 0;
end

// State transition logic
always @(*) begin
    next_state = current_state;
    case (current_state)
        WALK_LEFT: begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            if (bump_right) begin
                next_state <= WALK_RIGHT;
            end else if (!ground) begin
                next_state <= FALLING;
            end else if (dig) begin
                next_state <= DIGGING;
            end
        end
        WALK_RIGHT: begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
            if (bump_left) begin
                next_state <= WALK_LEFT;
            end else if (!ground) begin
                next_state <= FALLING;
            end else if (dig) begin
                next_state <= DIGGING;
            end
        end
        FALLING: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            if (ground) begin
                next_state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
            end
        end
        DIGGING: begin
            walk_left <= (walk_left) ? 1 : 0;
            walk_right <= (walk_right) ? 1 : 0;
            aaah <= 0;
            digging <= 1;
            if (!ground) begin
                next_state <= FALLING;
            end else if (!dig) begin
                next_state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
            end
        end
        default: begin
            next_state <= WALK_LEFT;
        end
    endcase
end

// State update logic
always @(posedge clk) begin
    current_state <= next_state;
end

endmodule
