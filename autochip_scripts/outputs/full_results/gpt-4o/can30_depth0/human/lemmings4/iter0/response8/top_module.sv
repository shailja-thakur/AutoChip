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

    reg [3:0] state, next_state;
    reg [4:0] fall_counter;   // 5-bit counter to count up to 20

    localparam WALK_LEFT = 4'b0001,
               WALK_RIGHT = 4'b0010,
               FALL_LEFT = 4'b0100,
               FALL_RIGHT = 4'b1000,
               DIGGING_LEFT = 4'b0110,
               DIGGING_RIGHT = 4'b1010,
               SPLATTERED = 4'b0000;

    // State transitions and next state logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground && fall_counter > 5'd20)
                    next_state = SPLATTERED;
                else if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground && fall_counter > 5'd20)
                    next_state = SPLATTERED;
                else if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIGGING_LEFT;
            end
            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIGGING_RIGHT;
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
            default: next_state = SPLATTERED; // Failsafe state
        endcase
    end

    // State flip-flops and fall counter
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end
        else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 5'd1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case(state)
            WALK_LEFT: begin
                walk_left = 1'b1;
            end
            WALK_RIGHT: begin
                walk_right = 1'b1;
            end
            FALL_LEFT: begin
                aaah = 1'b1;
            end
            FALL_RIGHT: begin
                aaah = 1'b1;
            end
            DIGGING_LEFT: begin
                digging = 1'b1;
            end
            DIGGING_RIGHT: begin
                digging = 1'b1;
            end
            SPLATTERED: begin
                // All outputs remain 0
            end
        endcase
    end

endmodule
