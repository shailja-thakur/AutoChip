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
    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALL_LEFT = 3'b010,
        S_FALL_RIGHT = 3'b011,
        S_DIG_LEFT = 3'b100,
        S_DIG_RIGHT = 3'b101,
        S_SPLATTER = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to count up to 21

    // State transition logic
    always @(*) begin
        next_state = state; // default to current state
        case (state)
            S_WALK_LEFT: begin
                if (!ground) next_state = S_FALL_LEFT;
                else if (dig) next_state = S_DIG_LEFT;
                else if (bump_left) next_state = S_WALK_RIGHT;
            end
            S_WALK_RIGHT: begin
                if (!ground) next_state = S_FALL_RIGHT;
                else if (dig) next_state = S_DIG_RIGHT;
                else if (bump_right) next_state = S_WALK_LEFT;
            end
            S_FALL_LEFT: begin
                if (ground && fall_counter <= 20) next_state = S_WALK_LEFT;
                else if (ground && fall_counter > 20) next_state = S_SPLATTER;
            end
            S_FALL_RIGHT: begin
                if (ground && fall_counter <= 20) next_state = S_WALK_RIGHT;
                else if (ground && fall_counter > 20) next_state = S_SPLATTER;
            end
            S_DIG_LEFT: begin
                if (!ground) next_state = S_FALL_LEFT;
            end
            S_DIG_RIGHT: begin
                if (!ground) next_state = S_FALL_RIGHT;
            end
            S_SPLATTER: begin
                next_state = S_SPLATTER;
            end
            default: next_state = S_WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == S_FALL_LEFT || state == S_FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            S_WALK_LEFT: walk_left = 1;
            S_WALK_RIGHT: walk_right = 1;
            S_FALL_LEFT: aaah = 1;
            S_FALL_RIGHT: aaah = 1;
            S_DIG_LEFT: digging = 1;
            S_DIG_RIGHT: digging = 1;
            S_SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule
