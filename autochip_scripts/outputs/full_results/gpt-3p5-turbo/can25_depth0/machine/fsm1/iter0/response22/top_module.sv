module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b0;  // Reset state to B
        end else begin
            if (state) begin
                // State B
                if (in) begin
                    state <= 1'b1;  // Next state is B
                end else begin
                    state <= 1'b0;  // Next state is A
                end
            end else begin
                // State A
                if (in) begin
                    state <= 1'b0;  // Next state is A
                end else begin
                    state <= 1'b1;  // Next state is B
                end
            end
        end
    end
    
    assign out = state;
    
endmodule
