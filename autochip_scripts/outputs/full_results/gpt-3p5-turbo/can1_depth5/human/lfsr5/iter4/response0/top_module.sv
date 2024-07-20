module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    // Define internal signal for tap positions
    reg tap1, tap2;
    
    // Define internal signal for LFSR state
    reg [4:0] state;
    
    // Assign tap positions
    always @(*) begin
        tap1 = state[4] ^ state[2];
        tap2 = state[3] ^ state[2];
    end
    
    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 5'b1;
        else begin
            state[0] <= state[1];
            state[1] <= state[2];
            state[2] <= state[3];
            state[3] <= state[4] ^ tap1;
            state[4] <= tap2;
        end
    end
    
    // Assign output
    always @(posedge clk) begin
        q <= state;
    end
    
endmodule
