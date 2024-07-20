module top_module(
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
    reg prev_ground;

    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
        begin
            state <= WALK_LEFT;
            prev_ground <= 1'b1;
        end
        else
        begin
            case(state)
                WALK_LEFT:
                    if (bump_right)
                        state <= WALK_RIGHT;
                WALK_RIGHT:
                    if (bump_left)
                        state <= WALK_LEFT;
                FALL:
                    if (ground && !prev_ground)
                        state <= state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
            endcase
            prev_ground <= ground;
        end
    end
    
    assign walk_left = state == WALK_LEFT;
    assign walk_right = state == WALK_RIGHT;
    assign aaah = state == FALL;

endmodule
