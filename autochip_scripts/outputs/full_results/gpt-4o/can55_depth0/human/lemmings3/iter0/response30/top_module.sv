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
        FALL_DIG_LEFT = 3'b110,
        FALL_DIG_RIGHT = 3'b111
    } state_t;

    state_t state, next_state;
    
    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic    
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left || bump_right) begin
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
                end else if (bump_left || bump_right) begin
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
                    next_state = FALL_DIG_LEFT;
                end else begin
                    next_state = DIG_LEFT;
                end
            end
            
            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_DIG_RIGHT;
                end else begin
                    next_state = DIG_RIGHT;
                end
            end
            
            FALL_DIG_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = FALL_DIG_LEFT;
                end
            end
            
            FALL_DIG_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = FALL_DIG_RIGHT;
                end
            end
            
            default: begin
                next_state = WALK_LEFT; // Default safe state
            end
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (next_state)
                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end
                FALL_LEFT,
                FALL_DIG_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                FALL_RIGHT,
                FALL_DIG_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                DIG_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                DIG_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                default: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
        end
    end
    
endmodule
