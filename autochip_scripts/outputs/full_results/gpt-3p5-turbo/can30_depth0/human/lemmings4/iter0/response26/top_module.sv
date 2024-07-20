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

    parameter MAX_FALL_CYCLES = 20;

    reg [4:0] state;
    reg [4:0] next_state;

    reg [4:0] fall_counter;

    // State encoding
    parameter WALK_LEFT = 5'b00001;
    parameter WALK_RIGHT = 5'b00010;
    parameter FALLING = 5'b00100;
    parameter DIGGING = 5'b01000;
    parameter SPLATTER = 5'b10000;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            next_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        aaah = 0;
        walk_left = 0;
        walk_right = 0;
        digging = 0;

        next_state = state;

        case (state)
            WALK_LEFT: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = WALK_RIGHT;
                else if (fall_counter >= MAX_FALL_CYCLES && ground)
                    next_state = SPLATTER;
                else if (dig && ground)
                    next_state = DIGGING;
                else if (ground == 0)
                    next_state = FALLING;
            end
            WALK_RIGHT: begin
                if (bump_left || (bump_left && bump_right))
                    next_state = WALK_LEFT;
                else if (fall_counter >= MAX_FALL_CYCLES && ground)
                    next_state = SPLATTER;
                else if (dig && ground)
                    next_state = DIGGING;
                else if (ground == 0)
                    next_state = FALLING;
            end
            FALLING: begin
                if (fall_counter >= MAX_FALL_CYCLES && ground)
                    next_state = SPLATTER;
                else if (ground)
                    next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
                fall_counter <= fall_counter + 1;
            end
            DIGGING: begin
                if (fall_counter >= MAX_FALL_CYCLES)
                    next_state = SPLATTER;
                else if (ground && state == WALK_LEFT && !bump_right)
                    digging = 1;
                else if (ground && state == WALK_RIGHT && !bump_left)
                    digging = 1;
                else if (ground == 0)
                    next_state = FALLING;
            end
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            fall_counter <= 0;
        else if (state == FALLING && ground == 0)
            fall_counter <= fall_counter + 1;
        else if (state != FALLING)
            fall_counter <= 0;
    end

endmodule
