module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

// Intermediate register to hold next state of q
reg [511:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        next_q[0] = q[1]; // q[-1] is considered as 0
        next_q[511] = q[510]; // q[512] is considered as 0
        for (int i = 1; i < 511; i++) begin
            next_q[i] = q[i-1] ^ q[i+1];
        end
        q <= next_q;
    end
end

endmodule
