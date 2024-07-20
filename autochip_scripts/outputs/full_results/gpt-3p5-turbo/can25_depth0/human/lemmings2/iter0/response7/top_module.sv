module top_module 
(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    reg [1:0] state;

    parameter LEFT = 2'b00;
    parameter RIGHT = 2'b01;
    parameter FALL = 2'b10;

    always@(posedge clk, posedge areset)
    begin
        if (areset)
            state <= LEFT;
        else
        begin
            case (state)
                LEFT:
                begin
                    if (bump_left && !bump_right)
                        state <= RIGHT;
                    else if (!bump_left && bump_right)
                        state <= LEFT;
                    else if (bump_left && bump_right)
                        state <= RIGHT;
                    else if (!ground)
                        state <= FALL;
                end
                
                RIGHT:
                begin
                    if (bump_left && !bump_right)
                        state <= RIGHT;
                    else if (!bump_left && bump_right)
                        state <= LEFT;
                    else if (bump_left && bump_right)
                        state <= LEFT;
                    else if (!ground)
                        state <= FALL;
                end
                
                FALL:
                begin
                    if (ground)
                    begin
                        if (state == LEFT)
                            state <= LEFT;
                        else if (state == RIGHT)
                            state <= RIGHT;
                    end
                    else
                        state <= FALL;
                end
            endcase
        end
    end

    always@(state)
    begin
        case (state)
            LEFT:
            begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            
            RIGHT:
            begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            
            FALL:
            begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
