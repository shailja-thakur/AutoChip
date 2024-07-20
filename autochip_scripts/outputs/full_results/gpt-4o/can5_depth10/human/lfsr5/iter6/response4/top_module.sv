module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q <= {q[3:0], q[0] ^ q[2]};  // Feedback for taps at positions 5 (0 indexed 4) and 3 (0 indexed 2)
        end
    end
endmodule
