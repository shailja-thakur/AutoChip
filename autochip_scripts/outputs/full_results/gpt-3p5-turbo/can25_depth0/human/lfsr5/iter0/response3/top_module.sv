module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 5'b1;  // Reset the LFSR output to 1
        else
            state <= {state[2:0], state[4] ^ state[2]};  // Shift the LFSR and calculate the next state
    end
    
    assign q = state;
    
endmodule
