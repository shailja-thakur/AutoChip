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
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTERED = 3'b110
    } state_t;
    
    state_t current_state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to track falling time

    // Sequential Logic: State Transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL_LEFT || current_state == FALL_RIGHT) begin
                if (!ground)
                    fall_counter <= fall_counter + 1;
                else
                    fall_counter <= 0;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    // Combinational Logic: Next State Logic
    always @(*) begin
        case (current_state)
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
                    if (fall_counter > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = WALK_LEFT;
                end else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = WALK_RIGHT;
                end else
                    next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (digging && ground && !bump_left)
                    next_state = DIG_LEFT;
                else
                    next_state = WALK_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (digging && ground && !bump_right)
                    next_state = DIG_RIGHT;
                else
                    next_state = WALK_RIGHT;
            end
            SPLATTERED: next_state = SPLATTERED;
            default: next_state = WALK_LEFT;
        endcase
    end

    // Combinational Logic: Output Logic
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
            SPLATTERED: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
