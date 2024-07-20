module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b11; // initialize state to walk left
        else begin
            case (state)
                2'b00: // walking left state
                    if (bump_right)
                        state <= 2'b01; // switch to walking right state
                    else if (bump_left || (bump_left && bump_right))
                        state <= 2'b10; // switch to walking right state
                2'b01: // walking right state
                    if (bump_left)
                        state <= 2'b00; // switch to walking left state
                    else if (bump_left && bump_right)
                        state <= 2'b10; // switch to walking left state
                default:
                    state <= 2'b00; // default state is walking left
            endcase
        end
    end
    
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    
endmodule
