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

    typedef enum logic [3:0] {
        WALK_LEFT = 4'd0,
        WALK_RIGHT = 4'd1,
        FALL_LEFT = 4'd2,
        FALL_RIGHT = 4'd3,
        DIG_LEFT = 4'd4,
        DIG_RIGHT = 4'd5,
        SPLATTER = 4'd6
    } state_t;

    state_t current_state, next_state;
    reg [4:0] fall_count;  // 5-bit counter to count up to 20 cycles

    // State transition on clock posedge or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_count <= 5'd0;
        end else begin
            current_state <= next_state;

            // fall_count is reset when on ground or in walk/dig state
            if (ground) begin
                fall_count <= 5'd0;
            end else if (aaah) begin
                fall_count <= fall_count + 5'd1;
            end else begin
                fall_count <= 5'd0;
            end
        end
    end

    // Combinational logic to determine next state
    always_comb begin
        next_state = current_state;

        case (current_state)
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
            FALL_LEFT, FALL_RIGHT: begin
                if (fall_count > 20) begin
                    next_state = SPLATTER;
                end else if (ground) begin
                    next_state = (current_state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end
            end
            DIG_LEFT, DIG_RIGHT: begin
                if (!ground) begin
                    next_state = (current_state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER;  // Remain in splatter state
            end
            default: next_state = WALK_LEFT; // Default to WALK_LEFT just in case
        endcase
    end

    // Output logic based on state
    always_comb begin
        walk_left  = 0;
        walk_right = 0;
        aaah       = 0;
        digging    = 0;

        case (current_state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLATTER: begin
                // all outputs remain 0
            end
        endcase
    end

endmodule
