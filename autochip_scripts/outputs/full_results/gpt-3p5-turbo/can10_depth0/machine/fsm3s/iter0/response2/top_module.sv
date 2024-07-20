module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            state <= 2'b00;  // Set initial state to A
        else begin
            case(state)
                2'b00: begin  // State A
                    if(in)
                        state <= 2'b01;  // Change state to B if in is 1
                    else
                        state <= 2'b00;  // Remain in state A
                end
                
                2'b01: begin  // State B
                    if(in)
                        state <= 2'b01;  // Remain in state B if in is 1
                    else
                        state <= 2'b10;  // Change state to C
                end
                
                2'b10: begin  // State C
                    if(in)
                        state <= 2'b11;  // Change state to D if in is 1
                    else
                        state <= 2'b00;  // Change state to A
                end
                
                2'b11: begin  // State D
                    if(in)
                        state <= 2'b01;  // Change state to B if in is 1
                    else
                        state <= 2'b10;  // Change state to C
                end
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;  // Set out to 1 when state is D

endmodule
