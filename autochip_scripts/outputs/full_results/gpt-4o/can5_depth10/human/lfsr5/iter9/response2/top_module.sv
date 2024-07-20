module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            // Taps are at positions 5 and 3, but note that bit positions are 0-indexed in Verilog
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end
endmodule
