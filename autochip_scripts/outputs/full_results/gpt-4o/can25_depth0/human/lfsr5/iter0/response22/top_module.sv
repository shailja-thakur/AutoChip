module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Set LFSR output to 1 on reset
        end else begin
            // Taps at bit positions 5 and 3 (zero-indexed positions 4 and 2)
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
