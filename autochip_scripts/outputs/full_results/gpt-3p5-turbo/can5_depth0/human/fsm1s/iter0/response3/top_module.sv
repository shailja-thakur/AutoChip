module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= 2'b10; // B state
        else if (state == 2'b10) // B state
            state <= (in == 1'b0) ? 2'b10 : 2'b01; // Transition to A state if in=0, stay in B state if in=1
        else if (state == 2'b01) // A state
            state <= (in == 1'b0) ? 2'b10 : 2'b00; // Transition to B state if in=0, stay in A state if in=1
        else if (state == 2'b00) // A state
            state <= (in == 1'b0) ? 2'b10 : 2'b00; // Transition to B state if in=0, stay in A state if in=1
    end
    
    assign out = (state == 2'b00) ? 1'b0 : 1'b1; // Output is 0 in A state, 1 in B state
    
endmodule
