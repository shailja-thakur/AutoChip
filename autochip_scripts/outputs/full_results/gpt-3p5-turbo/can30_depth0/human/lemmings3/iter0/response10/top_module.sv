module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output aaah,
    output reg digging
);

    // Define states
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG,
        SWITCH_LEFT,
        SWITCH_RIGHT
    } state_t;

    // Initialize state
    reg [2:0] state;

    // Output assignment
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

    // State transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT:
                    if (bump_right && !bump_left)
                        state <= SWITCH_RIGHT;
                    else if (bump_right && bump_left)
                        state <= SWITCH_RIGHT;
                    else if (!bump_right && bump_left)
                        state <= SWITCH_RIGHT;
                    else if (ground == 0)
                        state <= FALL;
                    else if (dig)
                        state <= DIG;
                    else
                        state <= WALK_LEFT;
                WALK_RIGHT:
                    if (bump_left && !bump_right)
                        state <= SWITCH_LEFT;
                    else if (bump_left && bump_right)
                        state <= SWITCH_LEFT;
                    else if (!bump_left && bump_right)
                        state <= SWITCH_LEFT;
                    else if (ground == 0)
                        state <= FALL;
                    else if (dig)
                        state <= DIG;
                    else
                        state <= WALK_RIGHT;
                FALL:
                    if (ground == 1)
                        state <= WALK_LEFT;
                    else
                        state <= FALL;
                DIG:
                    if (ground == 0)
                        state <= FALL;
                    else
                        state <= DIG;
                SWITCH_LEFT:
                    state <= WALK_LEFT;
                SWITCH_RIGHT:
                    state <= WALK_RIGHT;
                default:
                    state <= WALK_LEFT;
            endcase
        end
    end

endmodule
