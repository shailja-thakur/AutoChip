module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] lfsr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 32'h1; // Reset q to 32'h1
        end else begin
            lfsr[31:1] <= {lfsr[30:0], lfsr[0]}; // Shift bits 31 to 1 one position to the left
            lfsr[0] <= lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]; // Calculate new value for bit 0
        end
    end

    assign q = lfsr;

endmodule
