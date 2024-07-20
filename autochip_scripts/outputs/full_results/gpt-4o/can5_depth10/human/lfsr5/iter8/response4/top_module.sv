module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            // Shift the register and apply taps
            q <= {q[3:0], q[4] ^ q[2]};  // Feedback for taps at positions 5 (bit index 4) and 3 (bit index 2)
        end
    end
endmodule
