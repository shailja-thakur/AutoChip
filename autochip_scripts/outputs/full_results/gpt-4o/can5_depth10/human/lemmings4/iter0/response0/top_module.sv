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

    typedef enum reg [2:0] {
        LEFT = 3'd0,
        RIGHT = 3'd1,
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3,
        DIG_LEFT = 3'd4,
        DIG_RIGHT = 3'd5,
        SPLAT = 3'd6
    } state_t;
    
    state_t state, next_state;
    reg [4:0] fall_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (aaah)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        next_state = state;
        
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
                if (ground && fall_count <= 20)
                    next_state = LEFT;
                else if (ground && fall_count > 20)
                    next_state = SPLAT;
            end
            
            FALL_RIGHT: begin
                aaah = 1;
                if (ground && fall_count <= 20)
                    next_state = RIGHT;
                else if (ground && fall_count > 20)
                    next_state = SPLAT;
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
            
            SPLAT: begin
                // remain in SPLAT state
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end

            default: next_state = LEFT;
        endcase
    end

endmodule
