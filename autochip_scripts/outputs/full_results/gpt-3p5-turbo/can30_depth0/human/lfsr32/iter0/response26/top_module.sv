module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] state; // internal state of the shift register
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 32'h1; // reset the shift register to 32'h1
            q <= 32'h1; // reset the output to 32'h1
        end else begin
            state <= {state[30:0], state[1] ^ state[21] ^ state[31] ^ state[0]}; // update the shift register using XOR gates
            q <= state; // update the output with the new state
        end
    end
endmodule
