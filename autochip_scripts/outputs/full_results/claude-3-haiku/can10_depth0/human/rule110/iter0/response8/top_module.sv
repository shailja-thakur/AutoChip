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
        // Advance the cellular automaton by one time step
        q[0] <= (q[511] == 1'b1) ? (q[0] == 1'b1) ? 1'b0 : 1'b1 : q[0];
        for (int i = 1; i < 511; i++) begin
            q[i] <= (q[i-1] == 1'b1) ? (q[i] == 1'b1) ? (q[i+1] == 1'b1) ? 1'b0 : 1'b1 : (q[i+1] == 1'b1) ? 1'b1 : 1'b0 : q[i];
        end
        q[511] <= (q[510] == 1'b1) ? (q[511] == 1'b1) ? 1'b0 : 1'b1 : q[511];
    end
end

endmodule
