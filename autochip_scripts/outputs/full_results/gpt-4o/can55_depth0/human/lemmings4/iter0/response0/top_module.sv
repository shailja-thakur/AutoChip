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
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALL_LEFT = 3'b010,
        S_FALL_RIGHT = 3'b011,
        S_DIG_LEFT = 3'b100,
        S_DIG_RIGHT = 3'b101,
        S_SPLATTER = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to count up to 20 clock cycles

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == S_FALL_LEFT || state == S_FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    always @(*) begin
        next_state = state; // Default to hold state
        case (state)
            S_WALK_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else if (dig)
                    next_state = S_DIG_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
            end
            S_WALK_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else if (dig)
                    next_state = S_DIG_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
            end
            S_FALL_LEFT, S_FALL_RIGHT: begin
                if (ground && fall_counter > 5'd20)
                    next_state = S_SPLATTER;
                else if (ground)
                    next_state = state == S_FALL_LEFT ? S_WALK_LEFT : S_WALK_RIGHT;
            end
            S_DIG_LEFT, S_DIG_RIGHT: begin
                if (!ground)
                    next_state = state == S_DIG_LEFT ? S_FALL_LEFT : S_FALL_RIGHT;
            end
            S_SPLATTER: begin
                // Remain in this state forever
            end
        endcase
    end

    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case (state)
            S_WALK_LEFT: walk_left = 1'b1;
            S_WALK_RIGHT: walk_right = 1'b1;
            S_FALL_LEFT, S_FALL_RIGHT: aaah = 1'b1;
            S_DIG_LEFT: digging = 1'b1;
            S_DIG_RIGHT: digging = 1'b1;
            S_SPLATTER: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end
endmodule
