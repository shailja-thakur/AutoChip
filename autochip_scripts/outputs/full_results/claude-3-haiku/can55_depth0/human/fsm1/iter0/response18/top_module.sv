module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1'b1; // reset to state B
        else begin
            case (state)
                1'b0: // state A
                    if (in)
                        state <= 1'b0; // stay in A
                    else
                        state <= 1'b1; // transition to B
                1'b1: // state B
                    if (in)
                        state <= 1'b1; // stay in B
                    else
                        state <= 1'b0; // transition to A
            endcase
        end
    end
    
    assign out = ~state; // out is 0 in state B, 1 in state A

endmodule
