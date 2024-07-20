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
        WALK_LEFT = 3'd0,
        WALK_RIGHT = 3'd1,
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3,
        DIG_LEFT = 3'd4,
        DIG_RIGHT = 3'd5,
        SPLATTER = 3'd6
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to count up to 20 clock cycles

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;         // Precedence 1: Falling
                else if (dig) next_state = DIG_LEFT;         // Precedence 2: Digging
                else if (bump_left) next_state = WALK_RIGHT; // Precedence 3: Switching direction
                else next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;        // Precedence 1: Falling
                else if (dig) next_state = DIG_RIGHT;        // Precedence 2: Digging
                else if (bump_right) next_state = WALK_LEFT; // Precedence 3: Switching direction
                else next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground && fall_counter > 20) next_state = SPLATTER;
                else if (ground) next_state = WALK_LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground && fall_counter > 20) next_state = SPLATTER;
                else if (ground) next_state = WALK_RIGHT;
                else next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                if (ground) fall_counter <= 0;
                else fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
        digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
    end

endmodule
