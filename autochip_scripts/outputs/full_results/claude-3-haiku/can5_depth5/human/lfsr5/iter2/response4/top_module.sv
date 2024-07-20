module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Reset the LFSR to 1
    end
    else begin
        q <= {q[3:0], q[4] ^ q[3]}; // Tap at bits 5 and 3
    end
end

endmodule
