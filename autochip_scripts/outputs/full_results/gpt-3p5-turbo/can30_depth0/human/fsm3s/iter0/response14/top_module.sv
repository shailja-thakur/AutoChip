module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;  // Initializing state to A
            out_reg <= 0;
        end else begin
            case(state)
                2'b00: begin  // State A
                    if (in)
                        state <= 2'b01;  // Transition to B
                    else
                        state <= 2'b00;  // Remain in A
                    out_reg <= 1'b0;
                end
                2'b01: begin  // State B
                    if (in)
                        state <= 2'b01;  // Remain in B
                    else
                        state <= 2'b10;  // Transition to C
                    out_reg <= 1'b0;
                end
                2'b10: begin  // State C
                    if (in)
                        state <= 2'b11;  // Transition to D
                    else
                        state <= 2'b00;  // Transition to A
                    out_reg <= 1'b0;
                end
                2'b11: begin  // State D
                    if (in)
                        state <= 2'b01;  // Transition to B
                    else
                        state <= 2'b10;  // Remain in D
                    out_reg <= 1'b1;
                end
            endcase
        end
    end
    
    assign out = out_reg;
    
endmodule
