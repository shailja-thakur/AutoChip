module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg state, nextState;
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 1'b0;  // Reset to state B
        else
            state <= nextState;  // Update state
        
        case (state)
            1'b0: begin
                if (in)
                    nextState <= 1'b0;  // Transition to state B if input is 1
                else
                    nextState <= 1'b1;  // Transition to state A if input is 0
            end
            1'b1: begin
                if (in)
                    nextState <= 1'b1;  // Transition to state A if input is 1
                else
                    nextState <= 1'b0;  // Transition to state B if input is 0
            end
        endcase
    end

    always @(state) begin
        out = state;
    end

endmodule
