module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Active-high synchronous reset to 1
        end else begin
            q <= {q[3] ^ q[0], q[4], q[3], q[2], q[1]};
            // New bit is XOR of tap positions 5 (q[4]) and 3 (q[2]) with the output bit (q[0])
        end
    end
endmodule
