module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1; // Reset to state B
        end
        else begin
            case (state)
                1'b0: // State A
                    if (in) begin
                        state <= 1'b0; // Stay in state A
                    end
                    else begin
                        state <= 1'b1; // Transition to state B
                    end
                1'b1: // State B
                    if (in) begin
                        state <= 1'b1; // Stay in state B
                    end
                    else begin
                        state <= 1'b0; // Transition to state A
                    end
            endcase
        end
    end
    
    assign out = state;

endmodule
