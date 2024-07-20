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
            state <= 2'b10; // reset to walk left state
        else begin
            case (state)
                2'b00: // walking left state
                    if (bump_right || (bump_left && !bump_right))
                        state <= 2'b01; // switch to walking right state
                2'b01: // walking right state
                    if (bump_left || (bump_left && bump_right))
                        state <= 2'b00; // switch to walking left state
            endcase
        end
    end
    
    always @(posedge clk) begin
        case (state)
            2'b00: // walking left state
                begin
                    walk_left <= 1;
                    walk_right <= 0;
                end
            2'b01: // walking right state
                begin
                    walk_left <= 0;
                    walk_right <= 1;
                end
        endcase
    end
endmodule
