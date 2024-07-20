module top_module (
    input clk,
    input reset,
    output reg [4:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset to 1
        end else begin
            q <= {q[0], q[4], q[3] ^ q[0], q[2], q[1]}; // Correctly place the XOR operation with taps at positions 5 and 3
        end
    end
endmodule
