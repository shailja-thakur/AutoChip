module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Galois LFSR with taps at bit positions 5 and 3
    wire feedback;

    assign feedback = q[4] ^ q[2];  // taps at bit positions 5 (q[4]) and 3 (q[2])

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Active-high synchronous reset to 1
        end else begin
            q <= {q[3:0], feedback};  // Shift left and insert feedback bit
        end
    end

endmodule
