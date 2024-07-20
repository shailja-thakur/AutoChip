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

    // Define the states
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG,
        SPLATTER
    } state_t;

    // Define the signals
    reg [2:0] state;
    reg [4:0] counter;

    // Define the outputs
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL) && (counter >= 20);
    assign digging = (state == DIG);

    // define parameterized delays
    localparam WALK_DELAY = 1;
    localparam FALL_DELAY = 1;
    localparam DIG_DELAY = 1;
    localparam SPLATTER_DELAY = 1;

    // Synchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            counter <= 0;
        end else begin
            case (state)
                WALK_LEFT:
                    if (bump_left)
                        state <= WALK_RIGHT;
                    else if (bump_right)
                        state <= WALK_LEFT;
                    else if (~ground)
                        state <= FALL;
                    else if (dig)
                        state <= DIG;
                WALK_RIGHT:
                    if (bump_right)
                        state <= WALK_LEFT;
                    else if (bump_left)
                        state <= WALK_RIGHT;
                    else if (~ground)
                        state <= FALL;
                    else if (dig)
                        state <= DIG;
                FALL:
                    if (ground)
                        state <= WALK_RIGHT;
                    else if (counter >= 20)
                        state <= SPLATTER;
                    else if (dig)
                        state <= DIG;
                DIG:
                    if (~ground)
                        state <= FALL;
                    else if (counter >= 20)
                        state <= SPLATTER;
                SPLATTER:
                    // stay in SPLATTER state forever
            endcase
            counter <= (state == FALL || state == DIG) ? counter + 1 : 0;
        end
    end
endmodule
