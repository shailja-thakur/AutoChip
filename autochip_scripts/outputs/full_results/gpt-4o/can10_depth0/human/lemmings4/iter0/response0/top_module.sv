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
    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLAT = 3'b110
    } state_t;
    
    state_t state, next_state;
    reg [4:0] fall_count; // 5-bit counter to count up to 20

    // State transition logic (combinational)
    always @(*) begin
        // Defaults
        next_state = state;

        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end
            end

            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = WALK_LEFT;
                    end
                end
            end
            
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end

            DIG_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end
            end
            
            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end
            end

            SPLAT: begin
                // remain in SPLAT state
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (next_state == FALL_LEFT || next_state == FALL_RIGHT) begin
                if (state == next_state) begin
                    fall_count <= fall_count + 1;
                end else begin
                    fall_count <= 0;
                end
            end else begin
                fall_count <= 0;
            end
        end
    end

    // Output logic (combinational)
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
        digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
        if (state == SPLAT) begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    end

endmodule
