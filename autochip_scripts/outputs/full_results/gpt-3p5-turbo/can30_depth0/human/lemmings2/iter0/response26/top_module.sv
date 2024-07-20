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

    reg [1:0] state;

    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 0;
        else begin
            case (state)
                0: begin // walking left
                    if (bump_right)
                        state <= 1; // switch to walking right
                    else if (ground == 0)
                        state <= 2; // fall state
                end
                1: begin // walking right
                    if (bump_left)
                        state <= 0; // switch to walking left
                    else if (ground == 0)
                        state <= 2; // fall state
                end
                2: begin // falling
                    if (ground == 1)
                        state <= walk_right ? 1 : 0; // resume walking in the same direction as before the fall
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            0: begin // walking left
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            1: begin // walking right
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            2: begin // falling
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
