module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    parameter WL = 1'b0; // Left walking state
    parameter WR = 1'b1; // Right walking state
    
    reg state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= WL; // Reset to initial state
        end
        else begin
            case (state)
                WL: begin
                    if (bump_left) begin
                        state <= WR; // Transition to right walking state
                    end
                    else begin
                        state <= WL; // Remain in left walking state
                    end
                end
                WR: begin
                    if (bump_right) begin
                        state <= WL; // Transition to left walking state
                    end
                    else begin
                        state <= WR; // Remain in right walking state
                    end
                end
                default: begin
                    state <= WL; // Default to left walking state
                end
            endcase
        end
    end
    
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            WR: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
