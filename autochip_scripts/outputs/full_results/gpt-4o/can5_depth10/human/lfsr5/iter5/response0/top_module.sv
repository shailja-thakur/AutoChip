module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q <= {q[3:0], q[0] ^ q[2]};  // Shift left and XOR tap positions (bit 5 and bit 3)
        end
    end
endmodule
