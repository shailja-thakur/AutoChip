module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b10001; // Set the initial state to 10001, which is a valid maximum-length LFSR state
    end
    else begin
        q <= {q[3] ^ q[0], q[4:1]}; // Tap at bits 5 and 3
    end
end

endmodule
