module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    reg state;
    
    // On rising edge of areset, reset to state B
    always @(posedge areset) begin
        state <= 1'b0;
    end
    
    // On rising edge of clk, update state based on input
    always @(posedge clk) begin
        case (state)
            1'b0: begin        // State A
                if (in)
                    state <= 1'b0;
                else
                    state <= 1'b1;
            end
            1'b1: begin        // State B
                if (in)
                    state <= 1'b1;
                else
                    state <= 1'b0;
            end
        endcase
    end
    
    // Assign output based on state
    assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
