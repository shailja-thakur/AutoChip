module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    reg [1:0] state;        // state variable to track the Lemming state

    // parameter values for the states
    localparam LEFT = 2'b00;
    localparam RIGHT = 2'b01;
    localparam FALL = 2'b10;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= LEFT;         // reset to initial state (walk left)
        else
        begin
            case(state)
                LEFT:
                    if (bump_right)
                        state <= RIGHT;     // bump on right, switch to walk right state
                    else if (ground == 0)
                        state <= FALL;      // no bump and ground=0, fall state
                RIGHT:
                    if (bump_left)
                        state <= LEFT;      // bump on left, switch to walk left state
                    else if (ground == 0)
                        state <= FALL;      // no bump and ground=0, fall state
                FALL:
                    if (ground == 1)
                        state <= (bump_right || bump_left) ? RIGHT : LEFT;  // ground reappears, switch to walk state based on bump inputs
            endcase
        end
    end

    // state outputs
    assign walk_left = (state == LEFT) ? 1 : 0;
    assign walk_right = (state == RIGHT || state == FALL) ? 1 : 0;

    // output "aaah" when falling
    assign aaah = (state == FALL) ? 1 : 0;

endmodule
