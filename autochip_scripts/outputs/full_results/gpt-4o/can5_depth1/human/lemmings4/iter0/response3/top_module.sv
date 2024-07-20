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
    
    // State declaration
    typedef enum reg [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALLING_LEFT = 3'b010,
        FALLING_RIGHT = 3'b011,
        DIGGING_LEFT = 3'b100,
        DIGGING_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;
    
    reg [4:0] fall_count; // To track fall duration, 5 bits to cover counts up to 32
    reg state, next_state;
    
    // State transition
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)                      next_state = FALLING_LEFT;
                else if (dig)                     next_state = DIGGING_LEFT;
                else if (bump_left || bump_right) next_state = RIGHT;
                else                              next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)                      next_state = FALLING_RIGHT;
                else if (dig)                     next_state = DIGGING_RIGHT;
                else if (bump_left || bump_right) next_state = LEFT;
                else                              next_state = RIGHT;
            end
            DIGGING_LEFT: begin
                if (!ground)                      next_state = FALLING_LEFT;
                else                              next_state = DIGGING_LEFT;
            end
            DIGGING_RIGHT: begin
                if (!ground)                      next_state = FALLING_RIGHT;
                else                              next_state = DIGGING_RIGHT;
            end
            FALLING_LEFT: begin
                if (ground) begin
                    if (fall_count >= 21)         next_state = SPLATTER;
                    else                          next_state = LEFT;
                end
                else                              next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground) begin
                    if (fall_count >= 21)         next_state = SPLATTER;
                    else                          next_state = RIGHT;
                end
                else                              next_state = FALLING_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = LEFT;
        endcase
    end
    
    // State and output updates
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            state <= next_state;
            
            case (next_state)
                LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
                RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
                DIGGING_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall_count <= 0;
                end
                DIGGING_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall_count <= 0;
                end
                FALLING_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall_count <= fall_count + 1;
                end
                FALLING_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall_count <= fall_count + 1;
                end
                SPLATTER: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
            endcase
        end
    end
    
endmodule
