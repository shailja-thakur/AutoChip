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

    reg [3:0] state, next_state;
    reg [4:0] fall_count;

    // State encoding
    localparam WALK_LEFT  = 4'd0;
    localparam WALK_RIGHT = 4'd1;
    localparam FALL_LEFT  = 4'd2;
    localparam FALL_RIGHT = 4'd3;
    localparam DIG_LEFT   = 4'd4;
    localparam DIG_RIGHT  = 4'd5;
    localparam SPLATTER   = 4'd6;

    // State transition
    always @(*) begin
        case(state)
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
                if (ground)
                    next_state = (fall_count >= 20) ? SPLATTER : WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = (fall_count >= 20) ? SPLATTER : WALK_RIGHT;
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
                next_state = SPLATTER; // Stay in splatter state forever
            end
            default: next_state = WALK_LEFT;
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (next_state == FALL_LEFT || next_state == FALL_RIGHT)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case(state)
            WALK_LEFT:   walk_left = 1;
            WALK_RIGHT:  walk_right = 1;
            FALL_LEFT:   aaah = 1;
            FALL_RIGHT:  aaah = 1;
            DIG_LEFT:    digging = 1;
            DIG_RIGHT:   digging = 1;
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule
