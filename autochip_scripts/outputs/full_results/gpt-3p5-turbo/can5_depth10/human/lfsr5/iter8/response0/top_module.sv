module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Register to store the current state of the LFSR
    reg [4:0] state;

    always @(posedge clk)
        if (reset)
            state <= 5'b1;
        else begin
            // Next state calculation
            state[4] <= state[3] ^ state[2];
            state[3:0] <= state[4:1];
        end

    assign q = state;

endmodule
