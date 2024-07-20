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

// Define state enumeration
typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALLING,
    DIGGING,
    SPLATTERED
} state_t;

// Define state register
reg [2:0] current_state;
reg [2:0] next_state;

// Define outputs
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

// Define local variables
reg [4:0] fall_counter;

// Define state transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

// Define state output logic
always @* begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                next_state = current_state;
            end
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                next_state = current_state;
            end
        end
        FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            if (ground) begin
                fall_counter <= 0;
                next_state = current_state;
            end else if (fall_counter == 20) begin
                next_state = SPLATTERED;
            end else begin
                fall_counter <= fall_counter + 1;
                next_state = current_state;
            end
        end
        DIGGING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
            if (!ground) begin
                next_state = FALLING;
            end else begin
                next_state = current_state;
            end
        end
        SPLATTERED: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            next_state = current_state;
        end
    endcase
end

endmodule
