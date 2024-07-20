module top_module (
    input wire clk,
    input wire areset,
    input wire bump_left,
    input wire bump_right,
    input wire ground,
    input wire dig,
    output wire walk_left,
    output wire walk_right,
    output wire aaah,
    output wire digging
);
    
    // Define states
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG,
        SPLATTER
    } State;

    // Define state register and next state
    logic [2:0] state_reg, state_next;
    
    always @(posedge clk, negedge areset)
    begin
        if(areset)
            state_reg <= WALK_LEFT; // Reset to WALK_LEFT state
        else
            state_reg <= state_next;
    end

    // Output variables
    logic walk_left_out;
    logic walk_right_out;
    logic aaah_out;
    logic digging_out;

    always @(*)
    begin
        // Default outputs
        walk_left_out = 0;
        walk_right_out = 0;
        aaah_out = 0;
        digging_out = 0;

        // State transition and output logic
        case(state_reg)
            WALK_LEFT:
                begin
                    walk_left_out = 1;
                    if(bump_right)
                        state_next = WALK_RIGHT;
                    else if(dig && ground)
                        state_next = DIG;
                    else if(!ground)
                        state_next = FALL;
                end
            WALK_RIGHT:
                begin
                    walk_right_out = 1;
                    if(bump_left)
                        state_next = WALK_LEFT;
                    else if(dig && ground)
                        state_next = DIG;
                    else if(!ground)
                        state_next = FALL;
                end
            FALL:
                begin
                    aaah_out = 1;
                    if(ground)
                        state_next = state_reg; // Stay in FALL state
                    else if(dig && ground)
                        state_next = DIG;
                    else if(bump_left || bump_right)
                        state_next = state_reg; // Stay in FALL state
                    else
                        state_next = WALK_LEFT; // Default to WALK_LEFT
                end
            DIG:
                begin
                    digging_out = 1;
                    if(!ground)
                        state_next = FALL;
                    else if(bump_left || bump_right)
                        state_next = state_reg; // Stay in DIG state
                    else if(!dig)
                        state_next = WALK_LEFT; // Default to WALK_LEFT
                end
            SPLATTER:
                begin
                    walk_left_out = 0;
                    walk_right_out = 0;
                    aaah_out = 0;
                    digging_out = 0;
                    state_next = SPLATTER; // Stay in SPLATTER state
                end
            default:
                begin
                    walk_left_out = 0;
                    walk_right_out = 0;
                    aaah_out = 0;
                    digging_out = 0;
                    state_next = WALK_LEFT; // Default to WALK_LEFT state
                end
        endcase
    end

    // Assign output signals
    assign walk_left = walk_left_out;
    assign walk_right = walk_right_out;
    assign aaah = aaah_out;
    assign digging = digging_out;

endmodule
