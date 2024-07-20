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
    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else begin
                    next_state = DIG_LEFT;
                end
            end
            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else begin
                    next_state = DIG_RIGHT;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
        digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
    end

endmodule
