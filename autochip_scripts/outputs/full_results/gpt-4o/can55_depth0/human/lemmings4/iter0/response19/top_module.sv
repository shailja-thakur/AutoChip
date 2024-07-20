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

    // State definitions
    typedef enum reg [3:0] {
        WALK_LEFT = 4'b0000,
        WALK_RIGHT = 4'b0001,
        FALL_LEFT = 4'b0010,
        FALL_RIGHT = 4'b0011,
        DIG_LEFT = 4'b0100,
        DIG_RIGHT = 4'b0101,
        SPLATTER = 4'b0110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to count up to 20 cycles

    // State transition logic
    always @* begin
        next_state = state;
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
            end
            FALL_LEFT: begin
                if (ground) 
                    if (fall_counter >= 20) next_state = SPLATTER;
                    else next_state = WALK_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) 
                    if (fall_counter >= 20) next_state = SPLATTER;
                    else next_state = WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
            end
            SPLATTER: begin
                // Remain in SPLATTER state forever or until reset
            end
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                if (!ground) fall_counter <= fall_counter + 1;
                else fall_counter <= 5'd0;
            end else begin
                fall_counter <= 5'd0;
            end
            state <= next_state;
        end
    end

    // Output logic
    always @* begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case (state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALL_LEFT,
            FALL_RIGHT: aaah = 1'b1;
            DIG_LEFT: digging = 1'b1;
            DIG_RIGHT: digging = 1'b1;
            SPLATTER: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule
