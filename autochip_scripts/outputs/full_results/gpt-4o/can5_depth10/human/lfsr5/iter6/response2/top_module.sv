module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q <= {q[3:0], q[4] ^ q[2]};  // Feedback for taps at positions 5 and 3, q[4] represents the 5th bit
        end
    end
endmodule
