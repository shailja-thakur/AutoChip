module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        AA_AH = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            default: next_state = WALK_LEFT; // undefined states go to WALK_LEFT
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
            default: begin
                walk_left = 1; // default state should make the lemming walk left
            end
        endcase
    end

endmodule
