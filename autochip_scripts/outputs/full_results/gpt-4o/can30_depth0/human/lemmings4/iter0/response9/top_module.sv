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

    // State encoding
    typedef enum reg [2:0] {
        WLK_LEFT  = 3'b000,  // Walking left
        WLK_RIGHT = 3'b001,  // Walking right
        FALL_LEFT = 3'b010,  // Falling, was walking left
        FALL_RIGHT = 3'b011, // Falling, was walking right
        DIG_LEFT  = 3'b100,  // Digging, was walking left
        DIG_RIGHT = 3'b101,  // Digging, was walking right
        SPLATTER  = 3'b110   // Splattered
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter;

    // State transition logic
    always @(*) begin
        case (state)
            WLK_LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = WLK_RIGHT;
                else
                    next_state = WLK_LEFT;
            end
            
            WLK_RIGHT: begin
                if (!ground) 
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WLK_LEFT;
                else
                    next_state = WLK_RIGHT;
            end

            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WLK_LEFT;
                end
                else
                    next_state = FALL_LEFT;
            end

            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WLK_RIGHT;
                end
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
                next_state = SPLATTER;
            end

            default: begin
                next_state = WLK_LEFT;
            end
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WLK_LEFT;
            fall_counter <= 0;
        end
        else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            WLK_LEFT: walk_left = 1;
            WLK_RIGHT: walk_right = 1;
            FALL_LEFT: aaah = 1;
            FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule
