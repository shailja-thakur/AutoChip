module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    reg walk_left;
    reg walk_right;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Start in the walking left state
        else begin
            case (state)
                2'b01: begin // Walking left state
                    if (bump_right)
                        state <= 2'b10; // Switch to the walking right state
                    else
                        state <= 2'b01; // Stay in the walking left state
                end
                
                2'b10: begin // Walking right state
                    if (bump_left)
                        state <= 2'b01; // Switch to the walking left state
                    else
                        state <= 2'b10; // Stay in the walking right state
                end
            endcase
        end
    end
    
    always @(*) begin
        case (state)
            2'b01: begin // Walking left state
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            
            2'b10: begin // Walking right state
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
        endcase
    end

endmodule
