module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state;
    
    // Next state logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Reset to state B
        else begin
            case (state)
                A: begin
                    if (in)
                        state <= A;
                    else
                        state <= B;
                end
                B: begin
                    if (in)
                        state <= B;
                    else
                        state <= A;
                end
            endcase
        end
    end
    
    // Output logic
    always @(state) begin
        if (state == A)
            out <= 1'b0;
        else
            out <= 1'b1;
    end

endmodule
