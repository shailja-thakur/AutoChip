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
    // State encoding
    typedef enum logic [2:0] {
        LEFT_WALK = 3'b000,
        RIGHT_WALK = 3'b001,
        LEFT_FALL = 3'b010,
        RIGHT_FALL = 3'b011,
        LEFT_DIG = 3'b100,
        RIGHT_DIG = 3'b101,
        SPLATTER = 3'b110
    } state_t;
    
    state_t state, next_state;
    integer fall_counter;
    
    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            LEFT_WALK: begin
                if (!ground)
                    next_state = LEFT_FALL;
                else if (dig)
                    next_state = LEFT_DIG;
                else if (bump_left)
                    next_state = RIGHT_WALK;
            end
            RIGHT_WALK: begin
                if (!ground)
                    next_state = RIGHT_FALL;
                else if (dig)
                    next_state = RIGHT_DIG;
                else if (bump_right)
                    next_state = LEFT_WALK;
            end
            LEFT_FALL: begin
                if (ground)
                    next_state = (fall_counter > 20) ? SPLATTER : LEFT_WALK;
            end
            RIGHT_FALL: begin
                if (ground)
                    next_state = (fall_counter > 20) ? SPLATTER : RIGHT_WALK;
            end
            LEFT_DIG: begin
                if (!ground)
                    next_state = LEFT_FALL;
            end
            RIGHT_DIG: begin
                if (!ground)
                    next_state = RIGHT_FALL;
            end
            default: begin // SPLATTER state
                next_state = SPLATTER;
            end 
        endcase
    end
    
    // State update and fall counter logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT_WALK;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == LEFT_FALL || state == RIGHT_FALL) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end
    
    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            LEFT_WALK: walk_left = 1;
            RIGHT_WALK: walk_right = 1;
            LEFT_FALL: aaah = 1;
            RIGHT_FALL: aaah = 1;
            LEFT_DIG: digging = 1;
            RIGHT_DIG: digging = 1;
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
