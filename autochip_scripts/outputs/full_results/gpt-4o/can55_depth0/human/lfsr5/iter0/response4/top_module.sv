module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    wire feedback;

    // XOR taps positions 4 and 2 (5 and 3 referred as bit positions index start from 1)
    assign feedback = q[4] ^ q[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset to '1' when reset is active high
            q <= 5'b00001;
        end else begin
            // Perform the Galois LFSR shift
            q <= {q[3:0], feedback};
        end
    end

endmodule
