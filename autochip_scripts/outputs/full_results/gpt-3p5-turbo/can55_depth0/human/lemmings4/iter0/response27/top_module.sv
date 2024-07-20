module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;

    reg [4:0] state;
    reg [4:0] next_state;

    parameter WALK_LEFT = 1;
    parameter WALK_RIGHT = 2;
    parameter AAAH = 3;
    parameter DIGGING = 4;
    parameter SPLATTER = 5;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    always @(state or bump_left or bump_right or ground or dig) begin
        next_state = state;

        case (state)
            WALK_LEFT:
                begin
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                    
                    if (bump_right)
                        next_state = WALK_RIGHT;
                    else if (!ground)
                        next_state = AAAH;
                    else if (dig)
                        next_state = DIGGING;
                end
            WALK_RIGHT:
                begin
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                    digging = 0;
                    
                    if (bump_left)
                        next_state = WALK_LEFT;
                    else if (!ground)
                        next_state = AAAH;
                    else if (dig)
                        next_state = DIGGING;
                end
            AAAH:
                begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 1;
                    digging = 0;
                    
                    if (ground)
                        next_state = state;
                    else if (dig)
                        next_state = DIGGING;
                end
            DIGGING:
                begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 1;
                    
                    if (ground)
                        next_state = WALK_LEFT;
                    else if (dig)
                        next_state = state;
                end
            SPLATTER:
                begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end
        endcase
        
        if (state == SPLATTER && ground)
            next_state = WALK_LEFT;
        else if (state == SPLATTER && !ground)
            next_state = SPLATTER;
        else if (state != SPLATTER && !ground)
            next_state = state + 1;
            
        if (next_state == SPLATTER)
            next_state = SPLATTER;
    end

endmodule
