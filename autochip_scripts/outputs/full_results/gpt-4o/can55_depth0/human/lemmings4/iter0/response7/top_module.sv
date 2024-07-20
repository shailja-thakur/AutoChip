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

    // FSM states
    typedef enum reg [2:0] {
        LEFT_WALK = 3'b000,
        RIGHT_WALK = 3'b001,
        FALL_LEFT_WALK = 3'b010,
        FALL_RIGHT_WALK = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLAT = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to count up to 21 (more than 20 cycles)

    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT_WALK;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            
            // Count fall cycles
            if (state == FALL_LEFT_WALK || state == FALL_RIGHT_WALK) 
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end

    always @ (*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            LEFT_WALK: begin
                if (!ground)
                    next_state = FALL_LEFT_WALK;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT_WALK;
                else
                    next_state = LEFT_WALK;
                    
                walk_left = 1;
            end
            
            RIGHT_WALK: begin
                if (!ground)
                    next_state = FALL_RIGHT_WALK;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT_WALK;
                else
                    next_state = RIGHT_WALK;
                    
                walk_right = 1;
            end
            
            FALL_LEFT_WALK: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLAT;
                    else
                        next_state = LEFT_WALK;
                end else
                    next_state = FALL_LEFT_WALK;
            end

            FALL_RIGHT_WALK: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLAT;
                    else
                        next_state = RIGHT_WALK;
                end else
                    next_state = FALL_RIGHT_WALK;
            end

            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT_WALK;
                else
                    next_state = DIG_LEFT;
                    
                digging = 1;
            end 
            
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT_WALK;
                else
                    next_state = DIG_RIGHT;
                    
                digging = 1;
            end 
            
            SPLAT: begin
                aaah = 0;
                next_state = SPLAT;
            end

            default: begin
                next_state = LEFT_WALK;
            end
        endcase
    end

endmodule
