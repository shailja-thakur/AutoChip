module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset the LFSR to the value 1
        end else begin
            // Tap positions are 5 and 3 (1-indexed), which correspond to q[4] and q[2] (0-indexed)
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
