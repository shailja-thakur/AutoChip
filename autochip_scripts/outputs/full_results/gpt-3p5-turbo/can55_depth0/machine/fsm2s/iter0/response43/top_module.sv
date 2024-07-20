module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    reg [1:0] state; // Two-bit register to store the current state
    
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= 2'b0; // Initialize state to A when reset is high
        else if (state == 2'b00 && j)
            state <= 2'b01; // Transition to B when state is A and j is high
        else if (state == 2'b01 && ~j)
            state <= 2'b00; // Transition back to A when state is B and j is low
        else if (state == 2'b01 && k)
            state <= 2'b00; // Transition back to A when state is B and k is high
        else if (state == 2'b00 && ~k)
            state <= 2'b01; // Transition to B when state is A and k is low
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when state is B, and low when state is A
endmodule
