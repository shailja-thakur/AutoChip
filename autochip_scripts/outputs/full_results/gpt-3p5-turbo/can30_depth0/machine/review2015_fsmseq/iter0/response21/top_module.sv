module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    // Define states
    parameter S = 2'b00;
    parameter S1 = 2'b01;
    parameter S11 = 2'b10;
    parameter S110 = 2'b11;
    parameter Done = 2'b00;
    
    // Define reg for state
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;  // Reset to initial state
        else begin
            // Combinational logic to determine next state
            case (state)
                S: begin
                    if (data)
                        state <= S1;
                    else
                        state <= S;
                end
                
                S1: begin
                    if (data)
                        state <= S11;
                    else
                        state <= S;
                end
                
                S11: begin
                    if (data)
                        state <= S11;
                    else
                        state <= S110;
                end
                
                S110: begin
                    if (data)
                        state <= Done;
                    else
                        state <= S; 
                end
                
                Done: state <= Done;  // Stay in Done state
            endcase
        end
    end
    
    // Assign output based on current state
    assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

endmodule
