module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset to 1
        end else begin
            q <= {q[0], q[4:1]} ^ (q[4] ? 5'b00100 : 5'b00000); // Taps at positions 5 and 3
        end
    end
endmodule
