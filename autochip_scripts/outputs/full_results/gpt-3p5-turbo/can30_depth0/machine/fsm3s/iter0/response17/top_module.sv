module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    reg [1:0] state;  // 2-bit register to hold the current state
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;  // Set initial state to A when reset is high
        else begin
            case (state)  // State transition based on current state
                2'b00:  // A
                    if (in)
                        state <= 2'b01;  // Transition to B if in is 1
                    else
                        state <= 2'b00;  // Remain in A otherwise
                2'b01:  // B
                    if (in)
                        state <= 2'b01;  // Remain in B if in is 1
                    else
                        state <= 2'b10;  // Transition to C otherwise
                2'b10:  // C
                    if (in)
                        state <= 2'b11;  // Transition to D if in is 1
                    else
                        state <= 2'b00;  // Transition to A otherwise
                2'b11:  // D
                    if (in)
                        state <= 2'b01;  // Transition to B if in is 1
                    else
                        state <= 2'b10;  // Transition to C otherwise
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;  // Output is 1 when state is D, otherwise 0
endmodule
