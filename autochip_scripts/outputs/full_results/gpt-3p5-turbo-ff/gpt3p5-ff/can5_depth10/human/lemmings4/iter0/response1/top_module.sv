module top_module(
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
    
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;
    
    reg [1:0] state;
    reg [4:0] counter;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            counter <= 0;
        end else begin
            case (state)
                WALK_LEFT:
                    if (bump_right)
                        state <= WALK_RIGHT;
                    else if (!ground)
                        state <= FALL;
                    else if (dig)
                        state <= DIG;
                WALK_RIGHT:
                    if (bump_left)
                        state <= WALK_LEFT;
                    else if (!ground)
                        state <= FALL;
                    else if (dig)
                        state <= DIG;
                FALL:
                    if (ground)
                        state <= WALK_LEFT;
                    else if (counter >= 20)
                        state <= FALL;
                DIG:
                    if (!ground)
                        state <= FALL;
                    else if (dig)
                        state <= DIG;
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            WALK_LEFT:
                begin
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end
            WALK_RIGHT:
                begin
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                    digging = 0;
                end
            FALL:
                begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 1;
                    digging = 0;
                end
            DIG:
                begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 1;
                end
        endcase
    end
    
    always @(posedge clk) begin
        if (!areset) begin
            counter <= counter + 1;
            if (ground)
                counter <= 0;
        end
    end
    
endmodule
