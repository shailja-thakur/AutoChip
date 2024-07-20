module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset the LFSR to 1
        end
        else begin
            q[4] <= q[3] ^ q[0]; // Tap positions 5 and 3
            q[3:0] <= q[4:1]; // Shift the other bits
        end
    end

endmodule
