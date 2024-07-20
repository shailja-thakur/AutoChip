module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Synchronous reset to 1
        end else begin
            // Taps at bit positions 5 and 3 (considering LSB as bit position 1)
            q <= {q[3] ^ q[0], q[4:1]};
        end
    end
    
endmodule
