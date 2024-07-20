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

    // State declarations
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        FALL_DIG_LEFT = 3'b110,
        FALL_DIG_RIGHT = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            WALK_LEFT: begin
                if (~ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (~ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
            end
            FALL_LEFT: begin
                if (ground) next_state = WALK_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) next_state = WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (~ground) next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (~ground) next_state = FALL_RIGHT;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;

            case (current_state)
                WALK_LEFT: walk_left <= 1;
                WALK_RIGHT: walk_right <= 1;
                FALL_LEFT, FALL_RIGHT: aaah <= 1;
                DIG_LEFT, DIG_RIGHT: digging <= 1;
            endcase
        end
    end

endmodule
