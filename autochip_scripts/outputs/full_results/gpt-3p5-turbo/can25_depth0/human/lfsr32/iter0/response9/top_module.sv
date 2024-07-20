module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

reg [31:0] state; // register to hold the current state of the LFSR

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 32'h1; // reset the state to 32'h1 when reset is active high
    end else begin
        state <= {state[30:0], state[0] ^ state[9] ^ state[29] ^ state[31]}; // update the state using the taps at bit positions 32, 22, 2, and 1
    end
end

assign q = state; // assign the current state to the output q

endmodule
