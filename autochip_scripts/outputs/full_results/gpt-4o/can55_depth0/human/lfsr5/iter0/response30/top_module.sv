module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // on reset, set to 1.
        end else begin
            // Shift operation with taps at positions 5 and 3 (q[4] and q[2]).
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
