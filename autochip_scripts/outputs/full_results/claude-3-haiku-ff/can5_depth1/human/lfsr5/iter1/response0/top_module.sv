module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] next_q;

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Reset to 1, not 0
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q[4] = q[0] ^ q[2]; // Correct tap positions
    next_q[3] = q[4];
    next_q[2] = q[1];
    next_q[1] = q[0];
    next_q[0] = q[4] ^ q[2]; // Correct tap positions
end

endmodule
