module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Initialize to 1 on reset
        end 
        else begin
            // The taps are at bit positions 5 and 3 (1-based).
            // Feedback bit is calculated as XOR of the tapped bits
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end

endmodule
