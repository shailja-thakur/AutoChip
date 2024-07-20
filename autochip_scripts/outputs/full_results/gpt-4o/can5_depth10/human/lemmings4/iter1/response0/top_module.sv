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

    // State declarations
    typedef enum reg [2:0] {
        LEFT,
        RIGHT,
        FALL,
        DIG_LEFT,
        DIG_RIGHT,
        SPLAT
    } state_t;
    
    state_t state, next_state;
    reg [4:0] fall_counter; // Counter for falling cycles

    // State transition logic
    always @(*) begin
        case (state)
            LEFT:
                if (!ground) next_state = FALL;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            RIGHT:
                if (!ground) next_state = FALL;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            FALL:
                if (ground && fall_counter > 20) next_state = SPLAT;
                else if (ground) next_state = (walk_left) ? LEFT : RIGHT;
                else next_state = FALL;
            DIG_LEFT:
                if (!ground) next_state = FALL;
                else next_state = DIG_LEFT;
            DIG_RIGHT:
                if (!ground) next_state = FALL;
                else next_state = DIG_RIGHT;
            SPLAT:
                next_state = SPLAT;
            default:
                next_state = LEFT;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end
        else begin
            state <= next_state;
            if (state == FALL) begin
                fall_counter <= fall_counter + 1;
            end 
            else if (ground) begin
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
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
