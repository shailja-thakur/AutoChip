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

    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;
    
    state_t state, next_state;
    int fall_count;

    // State transition
    always @ (*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else if (dig) 
                    next_state = DIG_LEFT;
                else if (bump_left) 
                    next_state = WALK_RIGHT;
                else 
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground) 
                    next_state = FALL_RIGHT;
                else if (dig) 
                    next_state = DIG_RIGHT;
                else if (bump_right) 
                    next_state = WALK_LEFT;
                else 
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_LEFT;
                end
                else 
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_RIGHT;
                end
                else 
                    next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else 
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else 
                    next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: 
                next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end
        else begin
            state <= next_state;
            
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    // Output logic
    always @ (*) begin
        walk_left = (state == WALK_LEFT || state == DIG_LEFT);
        walk_right = (state == WALK_RIGHT || state == DIG_RIGHT);
        aaah = (state == FALL_LEFT || state == FALL_RIGHT);
        digging = (state == DIG_LEFT || state == DIG_RIGHT);
        
        if (state == SPLATTER) begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b0;
            digging = 1'b0;
        end
    end
endmodule
