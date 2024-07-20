module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);
    // Define states
    typedef enum logic [3:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG,
        SPLATTER
    } state_t;

    // Define signals
    logic [3:0] current_state;
    logic [4:0] counter;

    // Reset the FSM to initial state
    always @(posedge areset)
    begin
        current_state <= WALK_LEFT;
        counter <= 0;
    end

    // State transition logic
    always @(posedge clk)
    begin
        if (areset)
        begin
            current_state <= WALK_LEFT;
            counter <= 0;
        end
        else
        begin
            case (current_state)
                WALK_LEFT:
                    if (bump_right && ~bump_left)
                        current_state <= WALK_RIGHT;
                    else if (~bump_right && ~bump_left && ~ground)
                        current_state <= FALL;
                    else if (dig && ground)
                        current_state <= DIG;
                WALK_RIGHT:
                    if (bump_left && ~bump_right)
                        current_state <= WALK_LEFT;
                    else if (~bump_left && ~bump_right && ~ground)
                        current_state <= FALL;
                    else if (dig && ground)
                        current_state <= DIG;
                FALL:
                    if (ground)
                        current_state <= current_state == FALL ? WALK_LEFT : current_state;
                    else if ((bump_left || bump_right) && ~dig)
                        current_state <= current_state == FALL ? WALK_LEFT : current_state;
                    else if (counter == 20)
                        current_state <= SPLATTER;
                    else
                        current_state <= FALL;
                DIG:
                    if (~ground)
                        current_state <= FALL;
                    else if (~dig)
                        current_state <= current_state == FALL ? WALK_LEFT : current_state;
                SPLATTER:
                    current_state <= SPLATTER;
                default:
                    current_state <= WALK_LEFT;
            endcase
        end
    end

    // Output logic
    always @(*)
    begin
        walk_left = current_state == WALK_LEFT ? 1 : 0;
        walk_right = current_state == WALK_RIGHT ? 1 : 0;
        aaah = current_state == FALL || current_state == SPLATTER ? 1 : 0;
        digging = current_state == DIG ? 1 : 0;
    end
endmodule
