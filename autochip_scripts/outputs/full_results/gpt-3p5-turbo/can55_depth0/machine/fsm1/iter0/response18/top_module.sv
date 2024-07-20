module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1'b0; // Reset to state B
        else if (state) begin // State B
            if (in)
                state <= state;
            else
                state <= ~state;
        end
        else begin // State A
            if (in)
                state <= state;
            else
                state <= ~state;
        end
    end
    
    assign out = ~state;
    
endmodule
