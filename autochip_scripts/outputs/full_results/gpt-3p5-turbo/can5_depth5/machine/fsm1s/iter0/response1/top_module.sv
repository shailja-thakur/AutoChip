module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state;
    
    // Combinational logic to determine next state
    always @*
        if (state == A) begin
            if (in == 1'b1)
                state = A;
            else
                state = B;
        end else begin
            if (in == 1'b1)
                state = B;
            else
                state = A;
        end
    
    // Update state register on rising edge of clk
    always @(posedge clk)
        if (reset)
            state <= B;
        else
            state <= state;
    
    // Assign out output based on current state
    assign out = (state == B) ? 1'b1 : 1'b0;
    
endmodule
