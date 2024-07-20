module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    // Define state encoding
    typedef enum logic [2:0] {
        LEFT     = 3'b000,  // walking left
        RIGHT    = 3'b001,  // walking right
        FALLING  = 3'b010,  // falling
        DIG_LEFT = 3'b011,  // digging while walking left
        DIG_RIGHT= 3'b100,  // digging while walking right
        SPLATTER = 3'b101   // splattered
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_count;  // 5-bit counter for counting falls up to 20 cycles

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALLING);
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;

            if (state == FALLING && !ground) begin
                fall_count <= fall_count + 1;
            end else if (ground) begin
                fall_count <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = RIGHT;
                end
            end

            RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_left || bump_right) begin
                    next_state = LEFT;
                end
            end

            FALLING: begin
                if (ground) begin
                    if (fall_count > 20) begin
                        next_state = SPLATTER;
                    end else if (state == LEFT || state == DIG_LEFT) begin
                        next_state = LEFT;
                    end else begin
                        next_state = RIGHT;
                    end
                end
            end

            DIG_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end
            end

            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end
            end

            SPLATTER: begin
                next_state = SPLATTER;  // Remain in SPLATTER state
            end
        endcase
    end

endmodule
