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

    typedef enum logic [2:0] {
        LEFT  = 3'b000, // Walking left
        RIGHT = 3'b001, // Walking right
        FALL  = 3'b010, // Falling
        DIG   = 3'b011, // Digging
        SPLAT = 3'b100  // Splattered (dead)
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_count;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;

            if (state == FALL) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 0;
            end
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        next_state = state; // Default to staying in current state

        case (state)
            LEFT: begin
                walk_left = 1;
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG;
                else if (bump_left)
                    next_state = RIGHT;
            end

            RIGHT: begin
                walk_right = 1;
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG;
                else if (bump_right)
                    next_state = LEFT;
            end

            FALL: begin
                aaah = 1;
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLAT;
                    else
                        next_state = (state == LEFT) ? LEFT : RIGHT;
                end
            end

            DIG: begin
                digging = 1;
                if (!ground)
                    next_state = FALL;
            end
            
            SPLAT: begin
                // Do nothing, remain in splat state
            end
        endcase
    end
endmodule
