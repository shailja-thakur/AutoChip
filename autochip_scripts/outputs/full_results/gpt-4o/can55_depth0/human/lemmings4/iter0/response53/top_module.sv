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
    typedef enum logic [3:0] {
        LEFT   = 4'd1,
        RIGHT  = 4'd2,
        FALL_L = 4'd3,
        FALL_R = 4'd4,
        DIG_L  = 4'd5,
        DIG_R  = 4'd6,
        SPLAT  = 4'd7
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 5'd0;
        end
        else begin
            state <= next_state;
            if (state == FALL_L || state == FALL_R) begin
                fall_counter <= fall_counter + 5'd1;
            end
            else begin
                fall_counter <= 5'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to remain in the current state
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_L;
                else if (dig) next_state = DIG_L;
                else if (bump_left) next_state = RIGHT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_R;
                else if (dig) next_state = DIG_R;
                else if (bump_right) next_state = LEFT;
            end
            DIG_L: begin
                if (!ground) next_state = FALL_L;
            end
            DIG_R: begin
                if (!ground) next_state = FALL_R;
            end
            FALL_L: begin
                if (ground) next_state = (fall_counter > 20) ? SPLAT : LEFT;
            end
            FALL_R: begin
                if (ground) next_state = (fall_counter > 20) ? SPLAT : RIGHT;
            end
            SPLAT: begin
                // SPLAT is a terminal state
            end
            default: next_state = LEFT; // Default to handle unexpected states
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        else begin
            walk_left <= (state == LEFT);
            walk_right <= (state == RIGHT);
            aaah <= (state == FALL_L || state == FALL_R);
            digging <= (state == DIG_L || state == DIG_R);
        end
    end

endmodule
