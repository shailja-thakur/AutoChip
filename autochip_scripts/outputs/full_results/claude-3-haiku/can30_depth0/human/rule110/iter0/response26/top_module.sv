module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

// Perform Rule 110 cellular automaton
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Compute the next state of each cell
        q[511] <= (q[510] & q[511]) ? 0 : (q[510] ^ q[511]) ? 1 : 0;
        for (int i = 510; i > 0; i--) begin
            q[i] <= (q[i-1] & q[i]) ? 0 : (q[i-1] ^ q[i]) ? 1 : 0;
        end
        q[0] <= (q[0] & q[1]) ? 0 : (q[0] ^ q[1]) ? 1 : 0;
    end
end

endmodule
