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
    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLAT = 3'b110
    } state_t;

    state_t current_state, next_state;
    reg [4:0] fall_counter;  // 5-bit counter to count up to 20

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (current_state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT: aaah = 1;
            FALL_RIGHT: aaah = 1;
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

    // State transition logic
    always @(*) begin
        next_state = current_state;  // Default is to stay in the same state
        case (current_state)
            WALK_LEFT: 
                if (!ground)                next_state = FALL_LEFT;
                else if (dig)               next_state = DIG_LEFT;
                else if (bump_left)         next_state = WALK_RIGHT;
                
            WALK_RIGHT: 
                if (!ground)                next_state = FALL_RIGHT;
                else if (dig)               next_state = DIG_RIGHT;
                else if (bump_right)        next_state = WALK_LEFT;
                
            FALL_LEFT:
                if (ground && fall_counter <= 20) next_state = WALK_LEFT;
                else if (ground && fall_counter > 20) next_state = SPLAT;
                
            FALL_RIGHT:
                if (ground && fall_counter <= 20) next_state = WALK_RIGHT;
                else if (ground && fall_counter > 20) next_state = SPLAT;
                
            DIG_LEFT:
                if (!ground) next_state = FALL_LEFT;
                
            DIG_RIGHT:
                if (!ground) next_state = FALL_RIGHT;
                
            SPLAT:
                next_state = SPLAT; // Remain splat forever unless reset
                
            default: next_state = WALK_LEFT;
        endcase
    end

    // State and counter registers
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL_LEFT || current_state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

endmodule
