module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 5'b00001; // Reset to 1
    else begin
        q <= {q[3:0], q[4] ^ q[2]};
    end
end

endmodule
