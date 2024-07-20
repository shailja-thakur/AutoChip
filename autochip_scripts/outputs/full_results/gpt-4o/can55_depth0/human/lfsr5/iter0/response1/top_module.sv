module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Active-high synchronous reset to 1
        end else begin
            q <= {q[3:0], q[4] ^ q[2]}; // Shift left and XOR taps at positions 5 (q[4]) and 3 (q[2])
        end
    end
endmodule
