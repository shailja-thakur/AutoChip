module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    reg [1:0] state;
    reg [1:0] next_state;
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end
    
    always @*
    begin
        next_state = state;
        
        case (state)
            WALK_LEFT:
            begin
                if (bump_right && !bump_left && ground)
                    next_state = WALK_RIGHT;
                else if (bump_left && ground && !ground)
                    next_state = WALK_LEFT;
                else if (!ground)
                    next_state = FALL;
            end
            WALK_RIGHT:
            begin
                if (bump_left && !bump_right && ground)
                    next_state = WALK_LEFT;
                else if (bump_right && ground && !ground)
                    next_state = WALK_RIGHT;
                else if (!ground)
                    next_state = FALL;
            end
            FALL:
            begin
                if (ground)
                begin
                    if (state == WALK_LEFT)
                        next_state = WALK_LEFT;
                    else if (state == WALK_RIGHT)
                        next_state = WALK_RIGHT;
                end
            end
        endcase
    end
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
        begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
        end
        else
        begin
            case(state)
                WALK_LEFT:
                begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                end
                
                WALK_RIGHT:
                begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                end
                
                FALL:
                begin
                    walk_left <= (state == WALK_LEFT);
                    walk_right <= (state == WALK_RIGHT);
                    aaah <= 1'b1;
                end
            endcase
        end
    end

endmodule
