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
    typedef enum reg [3:0] {
        WALK_LEFT = 4'd0,
        WALK_RIGHT = 4'd1,
        FALL_LEFT = 4'd2,
        FALL_RIGHT = 4'd3,
        DIG_LEFT = 4'd4,
        DIG_RIGHT = 4'd5,
        SPLATTERED = 4'd6
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // To count up to more than 20 cycles

    // State transition logic
    always @(*) begin
        next_state = state; // Default state stays the same
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = WALK_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = WALK_RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            SPLATTERED: begin
                // Remain in SPLATTERED state
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT || (!ground && (next_state == FALL_LEFT || next_state == FALL_RIGHT)))
                fall_counter <= fall_counter + 1;
            else if (state != next_state)
                fall_counter <= 5'd0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case (state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALL_LEFT: aaah = 1'b1;
            FALL_RIGHT: aaah = 1'b1;
            DIG_LEFT: digging = 1'b1;
            DIG_RIGHT: digging = 1'b1;
            SPLATTERED: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule
