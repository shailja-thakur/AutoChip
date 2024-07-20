module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    // Internal registers
    reg [31:0] lfsr;

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 32'h1; // Reset the LFSR to 32'h1
            q <= 32'h1; // Reset the output to 32'h1
        end else begin
            lfsr <= {lfsr[30:0], lfsr[0] ^ lfsr[9] ^ lfsr[29] ^ lfsr[30]}; // Update the LFSR state
            q <= lfsr;
        end
    end
endmodule
