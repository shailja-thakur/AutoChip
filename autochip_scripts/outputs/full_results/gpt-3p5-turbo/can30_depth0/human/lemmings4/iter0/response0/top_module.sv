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
    parameter FALLING = 2'b10;
    parameter DIGGING = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            case (state)
                WALK_LEFT:
                    if (bump_right && !bump_left && ground)
                        state <= WALK_RIGHT;
                    else if (ground && !fall_counter)
                        state <= WALK_LEFT;
                    else if (!ground)
                        state <= FALLING;
                WALK_RIGHT:
                    if (bump_left && !bump_right && ground)
                        state <= WALK_LEFT;
                    else if (ground && !fall_counter)
                        state <= WALK_RIGHT;
                    else if (!ground)
                        state <= FALLING;
                FALLING:
                    if (ground && !fall_counter)
                        state <= state;  // Stay in the same state
                    else if (!ground && fall_counter < 21)
                        state <= FALLING;
                    else if (fall_counter >= 21)
                        state <= WALK_LEFT;
                DIGGING:
                    if (!dig || (ground && !fall_counter))
                        state <= state;  // Stay in the same state
                    else if (!ground)
                        state <= FALLING;
            endcase
        end
    end

    always @(posedge clk) begin
        case (state)
            WALK_LEFT:
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            WALK_RIGHT:
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
            FALLING:
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
            DIGGING:
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
        endcase
    end

    always @(posedge clk) begin
        if (state == FALLING && !ground)
            fall_counter <= fall_counter + 1;
        else if ((state == WALK_LEFT || state == WALK_RIGHT) && !ground)
            fall_counter <= 0;
    end

endmodule
