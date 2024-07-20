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
    logic [4:0] fall_counter;  // 5 bits to count up to 32 for the 20 clock cycle fall limit

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            // Update fall counter only if in FALL_LEFT or FALL_RIGHT states.
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                if (ground) begin
                    fall_counter <= 5'd0;
                end else begin
                    fall_counter <= fall_counter + 5'd1;
                end
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    always_comb begin
        next_state = state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                walk_right = 1;
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end
            end
            FALL_LEFT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter < 5'd20) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = SPLATTER;
                    end
                end
            end
            FALL_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter < 5'd20) begin
                        next_state = WALK_RIGHT;
                    end else begin
                        next_state = SPLATTER;
                    end
                end
            end
            DIG_LEFT: begin
                digging = 1;
                if (!ground) begin
                    next_state = FALL_LEFT;
                end
            end
            DIG_RIGHT: begin
                digging = 1;
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end
            end
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule
