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

    // State definitions
    typedef enum logic [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;
    
    state_t state, next_state;
    reg [4:0] fall_count; // 5-bit counter (0-31)

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (~ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = LEFT;
                end
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = RIGHT;
                end
                else
                    next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (~ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (~ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = LEFT;
        endcase
    end

    // Sequential logic for state transition and outputs
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_count <= fall_count + 1;
            else if (ground)
                fall_count <= 0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (state == LEFT) || (state == FALL_LEFT && fall_count <= 20);
        walk_right = (state == RIGHT) || (state == FALL_RIGHT && fall_count <= 20);
        aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
        digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
        
        // Ensure all outputs are zero in SPLATTER state
        if (state == SPLATTER) begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    end
endmodule
