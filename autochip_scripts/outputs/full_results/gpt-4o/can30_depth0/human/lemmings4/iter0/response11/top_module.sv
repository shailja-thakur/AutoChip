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

    reg [2:0] state, next_state;
    reg [4:0] fall_counter;  // Counter for falling cycles

    localparam WALK_LEFT   = 3'b000;
    localparam WALK_RIGHT  = 3'b001;
    localparam FALL_LEFT   = 3'b010;
    localparam FALL_RIGHT  = 3'b011;
    localparam DIG_LEFT    = 3'b100;
    localparam DIG_RIGHT   = 3'b101;
    localparam SPLATTERED  = 3'b110;

    // State transition
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = SPLATTERED;
                    else if (state == FALL_LEFT)
                        next_state = WALK_LEFT;
                    else
                        next_state = WALK_RIGHT;
                end else
                    next_state = state; // Continue falling
            end
            DIG_LEFT, DIG_RIGHT: begin
                if (!ground)
                    next_state = (state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
                else
                    next_state = state; // Continue digging
            end
            SPLATTERED: begin
                next_state = SPLATTERED; // Stay splattered
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;

            // Update fall counter
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 5'd0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
            end
            WALK_RIGHT: begin
                walk_right = 1;
            end
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1;
            end
            DIG_LEFT: begin
                digging = 1;
            end
            DIG_RIGHT: begin
                digging = 1;
            end
            SPLATTERED: begin
                // All outputs remain 0
            end
        endcase
    end

endmodule
