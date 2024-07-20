module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b01; // walking left
        else 
        begin
            case(state)
                2'b01: // walking left
                begin
                    if (bump_right)
                        state <= 2'b10; // walking right
                    else if (bump_left)
                        state <= 2'b01; // walking left
                end
                
                2'b10: // walking right
                begin
                    if (bump_left)
                        state <= 2'b01; // walking left
                    else if (bump_right)
                        state <= 2'b10; // walking right
                end
                
                default: state <= 2'b01; // default state is walking left
            endcase
        end
    end
    
    assign walk_left = (state == 2'b01) ? 1'b1 : 1'b0;
    assign walk_right = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
