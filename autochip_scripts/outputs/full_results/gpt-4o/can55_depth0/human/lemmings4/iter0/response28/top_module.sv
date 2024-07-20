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

    // Define the states
    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTERED = 3'b110
    } state_t;

    state_t state, next_state;

    reg [4:0] fall_counter; // Counter for tracking fall duration

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state machine to initial state
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            // Update the state and fall counter
            state <= next_state;
            if (aaah)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end

    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        next_state = state; // Default state transition

        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                if (~ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                walk_right = 1;
                if (~ground) begin
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
                    if (fall_counter > 20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = WALK_LEFT;
                    end
                end
            end
            FALL_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end
            DIG_LEFT: begin
                digging = 1;
                if (~ground) begin
                    next_state = FALL_LEFT;
                end
            end
            DIG_RIGHT: begin
                digging = 1;
                if (~ground) begin
                    next_state = FALL_RIGHT;
                end
            end
            SPLATTERED: begin
                // All outputs remain zero
            end
        endcase
    end
endmodule
