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
    typedef enum reg [3:0] {
        LEFT = 4'b0001,
        RIGHT = 4'b0010,
        FALL_LEFT = 4'b0100,
        FALL_RIGHT = 4'b1000,
        DIG_LEFT = 4'b0001 | 4'b1000,
        DIG_RIGHT = 4'b0010 | 4'b1000,
        SPLAT = 4'b1111
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // Counter for fall time

    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        next_state = state;

        case (state)
            LEFT: begin
                if (~ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
                walk_left = 1;
            end

            RIGHT: begin
                if (~ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = LEFT;
                walk_right = 1;
            end

            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLAT;
                    else next_state = LEFT;
                end
                aaah = 1;
            end

            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLAT;
                    else next_state = RIGHT;
                end
                aaah = 1;
            end

            DIG_LEFT: begin
                if (~ground) next_state = FALL_LEFT;
                digging = 1;
            end

            DIG_RIGHT: begin
                if (~ground) next_state = FALL_RIGHT;
                digging = 1;
            end

            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT; // Reset to initial state (walking left)
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

endmodule
