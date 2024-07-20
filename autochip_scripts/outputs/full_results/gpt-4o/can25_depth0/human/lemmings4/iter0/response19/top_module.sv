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

    // Define state encoding
    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL = 3'b010,
        DIG = 3'b011,
        SPLATTERED = 3'b100
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // To count the fall duration in cycles

    // State transition logic
    always @(*) begin
        case(state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            
            FALL: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTERED;
                    else if (walk_left)
                        next_state = WALK_LEFT;
                    else
                        next_state = WALK_RIGHT;
                end
                else
                    next_state = FALL;
            end
            
            DIG: begin
                if (!ground)
                    next_state = FALL;
                else
                    next_state = DIG;
            end
            
            SPLATTERED: begin
                next_state = SPLATTERED; // Remain in SPLATTERED state
            end
            
            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        else begin
            state <= next_state;
            case (next_state)
                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_counter <= 0;
                end
                
                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    fall_counter <= 0;
                end
                
                FALL: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    if (fall_counter != 5'b11111)
                        fall_counter <= fall_counter + 1;
                end
                
                DIG: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall_counter <= 0;
                end
                
                SPLATTERED: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_counter <= fall_counter;
                end
            endcase
        end
    end

endmodule
