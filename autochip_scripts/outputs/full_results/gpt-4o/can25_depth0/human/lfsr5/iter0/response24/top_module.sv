module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Set the LFSR to a non-zero state
        end else begin
            q[4] <= q[0];
            q[3] <= q[4];
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[4] ^ q[2]; // XOR taps at bit positions 5 and 3
        end 
    end
endmodule
