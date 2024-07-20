module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Compute the next state of the cellular automaton
        for (int i = 0; i < 512; i++) begin
            q[i] <= (i == 0 ? 1'b0 : q[i-1]) ^ q[i] ^ (i == 511 ? 1'b0 : q[i+1]);
        end
    end
end

endmodule
