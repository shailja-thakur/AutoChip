module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

    // State encoding
    typedef enum reg [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALL_LEFT = 2'b10,
        FALL_RIGHT = 2'b11
    } state_t;
    
    // State registers
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            state <= LEFT;
        end else begin
            // State transition
            state <= next_state;
        end
    end

    // State transitions and outputs
    always @(*) begin
        case (state)
            LEFT: begin
                aaah = 0;
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                aaah = 0;
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALL_LEFT: begin
                aaah = 1;
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            default: next_state = LEFT;  // Default to a known state
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            LEFT, FALL_LEFT: begin
                walk_left = (state == LEFT);
                walk_right = 0;
            end
            RIGHT, FALL_RIGHT: begin
                walk_left = 0;
                walk_right = (state == RIGHT);
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
            end
        endcase
    end
    
endmodule
