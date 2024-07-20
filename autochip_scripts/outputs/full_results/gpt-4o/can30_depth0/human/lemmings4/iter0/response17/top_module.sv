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
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLAT = 3'b110
    } state_t;

    state_t state, next_state;
    reg [5:0] fall_counter;

    // Output logic
    always @(*) begin
        // Default assignments
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            
            FALL_LEFT, FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLAT;
                    else if (state == FALL_LEFT) next_state = LEFT;
                    else next_state = RIGHT;
                end
                else next_state = state; // Continue falling
            end

            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            
            SPLAT: begin
                next_state = SPLAT; // Remain in SPLAT state forever until reset
            end
            
            default: next_state = LEFT;
        endcase
    end

    // Fall counter logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            fall_counter <= 0;
        end else if (aaah) begin
            fall_counter <= fall_counter + 1;
        end else begin
            fall_counter <= 0;
        end
    end

    // State transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

endmodule
