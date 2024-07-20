module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load)
        q <= data;
    else begin
        // Compute the next state of the cellular automaton
        q[0] <= q[1];
        q[511] <= 1'b0;
        for (int i = 1; i < 511; i++) begin
            q[i] <= q[i-1] ^ q[i+1];
        end
    end
end

endmodule
