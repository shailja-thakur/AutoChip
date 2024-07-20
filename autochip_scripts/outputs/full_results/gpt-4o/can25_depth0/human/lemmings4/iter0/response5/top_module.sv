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
        LEFT    = 3'b000,
        RIGHT   = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTER = 3'b111
    } state_t;
    
    state_t state, next_state;
    reg [4:0] fall_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 5'b0;
        end else begin
            state <= next_state;
            if (aaah) begin
                if (fall_count == 5'b11111) // Increment until we reach 20 cycles
                    fall_count <= fall_count;
                else
                    fall_count <= fall_count + 1;
            end else begin
                fall_count <= 5'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            LEFT: begin
                walk_left = 1;
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
            end
            RIGHT: begin
                walk_right = 1;
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
            end
            FALL_LEFT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = LEFT;
                end
            end
            FALL_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = RIGHT;
                end
            end
            DIG_LEFT: begin
                digging = 1;
                if (!ground)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                digging = 1;
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            default: next_state = LEFT;
        endcase
    end

endmodule
