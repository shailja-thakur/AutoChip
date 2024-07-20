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
    typedef enum logic[2:0] {
        S_WALK_LEFT  = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALL_LEFT  = 3'b010,
        S_FALL_RIGHT = 3'b011,
        S_DIG_LEFT   = 3'b100,
        S_DIG_RIGHT  = 3'b101,
        S_SPLATTER   = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter;

    // State transition logic
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (!ground) begin
                    next_state = S_FALL_LEFT;
                end else if (dig) begin
                    next_state = S_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = S_WALK_RIGHT;
                end else begin
                    next_state = S_WALK_LEFT;
                end
            end

            S_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = S_FALL_RIGHT;
                end else if (dig) begin
                    next_state = S_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = S_WALK_LEFT;
                end else begin
                    next_state = S_WALK_RIGHT;
                end
            end

            S_FALL_LEFT, S_FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = S_SPLATTER;
                    end else if (state == S_FALL_LEFT) begin
                        next_state = S_WALK_LEFT;
                    end else begin
                        next_state = S_WALK_RIGHT;
                    end
                end else begin
                    next_state = state;
                end
            end

            S_DIG_LEFT: begin
                if (!ground) begin
                    next_state = S_FALL_LEFT;
                end else if (!dig) begin
                    next_state = S_WALK_LEFT;
                end else begin
                    next_state = S_DIG_LEFT;
                end
            end

            S_DIG_RIGHT: begin
                if (!ground) begin
                    next_state = S_FALL_RIGHT;
                end else if (!dig) begin
                    next_state = S_WALK_RIGHT;
                end else begin
                    next_state = S_DIG_RIGHT;
                end
            end

            S_SPLATTER: begin
                next_state = S_SPLATTER;
            end

            default: begin
                next_state = S_WALK_LEFT;
            end
        endcase
    end

    // State and output register updates
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
        walk_left = (state == S_WALK_LEFT);
        walk_right = (state == S_WALK_RIGHT);
        aaah = (state == S_FALL_LEFT || state == S_FALL_RIGHT);
        digging = (state == S_DIG_LEFT || state == S_DIG_RIGHT);
    end

endmodule
