module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b00001;  // Initial value on reset
    end else begin
        // Feedback taps at positions 5 (q[4]) and 3 (q[2])
        q <= {q[3], q[2], q[1], q[0], q[4] ^ q[2]};
    end
end

endmodule
