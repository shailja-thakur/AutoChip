module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state;
    
    // State encoding: 0 for state A, 1 for state B
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 1'b1; // Asynchronous reset to state B
        else begin
            case (state)
                1'b0: // State A
                    if (in == 1'b0)
                        state <= 1'b1; // Transition to state B
                    else
                        state <= 1'b0; // Remain in state A
                1'b1: // State B
                    if (in == 1'b0)
                        state <= 1'b1; // Remain in state B
                    else
                        state <= 1'b0; // Transition to state A
            endcase
        end
    end
    
    // Output logic
    assign out = (state == 1'b0) ? 1'b0 : 1'b1;

endmodule
