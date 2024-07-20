module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q[0] <= q[4];  // New value for q[0] 
            q[1] <= q[0];  // Shift register logic
            q[2] <= q[1];  // Shift register logic
            q[3] <= q[2];  // Shift register logic
            q[4] <= q[3] ^ q[4];  // XOR with tap at bit 5 and 3
        end
    end
endmodule
