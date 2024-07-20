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
typedef enum logic [2:0] {
    IDLE,
    FALLING,
    DIGGING,
    WALKING_LEFT,
    WALKING_RIGHT,
} state_t;

// Define the current state and next state variables
reg [2:0] current_state;
reg [2:0] next_state;

// Initialize the current state to IDLE
initial begin
    current_state = IDLE;
end

// Assign the next state based on the current state and input signals
always_ff @(posedge clk, negedge areset) begin
    if (areset) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

// Assign the next state and output signals based on the current state and input signals
always_comb begin
    case (current_state)
        IDLE: begin
            if (areset) begin
                next_state = WALKING_LEFT;
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end else if (bump_left && bump_right) begin
                next_state = WALKING_RIGHT;
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end else if (bump_left) begin
                next_state = WALKING_RIGHT;
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end else if (bump_right) begin
                next_state = WALKING_LEFT;
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end else if (dig && ground) begin
                next_state = DIGGING;
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end else begin
                next_state = IDLE;
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        end

        FALLING: begin
            if (ground) begin
                next_state = current_state;
                walk_left = (current_state == WALKING_LEFT);
                walk_right = (current_state == WALKING_RIGHT);
                aaah = 0;
                digging = 0;
            end else begin
                next_state = FALLING;
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end
        end

        DIGGING: begin
            if (~ground) begin
                next_state = FALLING;
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end else begin
                next_state = DIGGING;
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
        end

        WALKING_LEFT: begin
            if (bump_right) begin
                next_state = WALKING_RIGHT;
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end else begin
                next_state = WALKING_LEFT;
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        end

        WALKING_RIGHT: begin
            if (bump_left) begin
                next_state = WALKING_LEFT;
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end else begin
                next_state = WALKING_RIGHT;
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
        end
    endcase
end

endmodule
