module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset the LFSR output to 1
        end else begin
            // Tap positions are at bit 5 (q[4]) and bit 3 (q[2]) in zero-indexed
            q <= {q[3], q[4] ^ q[2], q[1], q[0], q[4]};
        end
    end
endmodule
