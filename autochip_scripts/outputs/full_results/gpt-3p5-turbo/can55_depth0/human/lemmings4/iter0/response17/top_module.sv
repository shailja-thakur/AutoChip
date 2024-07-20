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

    reg [1:0] state;
    reg [4:0] fall_counter;

    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIGGING = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else begin
            case(state)
                WALK_LEFT:
                    if (bump_right && !bump_left)
                        state <= WALK_RIGHT;
                    else if (!bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (bump_right && bump_left)
                        state <= WALK_RIGHT;
                WALK_RIGHT:
                    if (bump_right && !bump_left)
                        state <= WALK_RIGHT;
                    else if (!bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (bump_right && bump_left)
                        state <= WALK_LEFT;
                FALL:
                    if (ground)
                        state <= WALK_LEFT;
                    else if (fall_counter >= 5'b10100)
                        state <= FALL;
                    else if (fall_counter < 5'b10100 && !ground)
                        state <= FALL;
                DIGGING:
                    if (ground && fall_counter <= 5'b10100)
                        state <= WALK_LEFT;
                    else if (!ground && fall_counter < 5'b10100)
                        state <= FALL;
            endcase
        end
    end

    always @(posedge clk) begin
        if (areset)
            fall_counter <= 0;
        else begin
            case(state)
                FALL:
                    if (ground)
                        fall_counter <= 0;
                    else if (!ground)
                        fall_counter <= fall_counter + 1;
                default:
                    fall_counter <= 0;
            endcase
        end
    end

    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIGGING && ground);

endmodule
