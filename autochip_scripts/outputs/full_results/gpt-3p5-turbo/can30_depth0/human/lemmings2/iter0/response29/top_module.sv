module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output aaah
);
    
    reg [1:0] state;
    parameter [1:0] WALK_LEFT = 2'b00;
    parameter [1:0] WALK_RIGHT = 2'b01;
    parameter [1:0] FALL = 2'b10;
    parameter [1:0] RECOVER = 2'b11;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else begin
            case(state)
                WALK_LEFT:
                    if (bump_right && !bump_left)
                        state <= WALK_RIGHT;
                    else if (bump_right && bump_left)
                        state <= WALK_RIGHT;
                    else if (!bump_right && !bump_left && !ground)
                        state <= FALL;
                    else
                        state <= WALK_LEFT;
                WALK_RIGHT:
                    if (!bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (!bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (!bump_right && !bump_left && !ground)
                        state <= FALL;
                    else
                        state <= WALK_RIGHT;
                FALL:
                    if (ground)
                        state <= RECOVER;
                    else
                        state <= FALL;
                RECOVER:
                    if (bump_right && !bump_left)
                        state <= WALK_RIGHT;
                    else if (bump_right && bump_left)
                        state <= WALK_RIGHT;
                    else if (!bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (!bump_right && !bump_left && !ground)
                        state <= FALL;
                    else
                        state <= RECOVER;
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            WALK_LEFT:
                begin
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                end
            WALK_RIGHT:
                begin
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                end
            FALL:
                begin
                    walk_left = walk_left;
                    walk_right = walk_right;
                    aaah = 1;
                end
            RECOVER:
                begin
                    walk_left = walk_left;
                    walk_right = walk_right;
                    aaah = 0;
                end
        endcase
    end
endmodule
