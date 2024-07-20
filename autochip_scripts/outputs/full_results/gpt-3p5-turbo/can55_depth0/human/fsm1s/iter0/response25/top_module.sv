module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b1;  // Reset state B
        else begin
            case (state)
                2'b00: begin  // State A
                    if (in)
                        state <= 2'b01;  // Transition to A
                    else
                        state <= 2'b00;  // Remain in A
                end
                
                2'b01: begin  // State B
                    if (in)
                        state <= 2'b01;  // Remain in B
                    else
                        state <= 2'b00;  // Transition to B
                end
            endcase
        end
    end
    
    assign out = (state == 2'b00) ? 1'b0 : 1'b1;  // Output of A is 0, output of B is 1

endmodule
