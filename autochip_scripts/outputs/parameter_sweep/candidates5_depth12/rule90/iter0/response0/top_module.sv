module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] q_temp;

// Logic for loading initial state of the system
always @ (posedge clk) begin
    if (load) begin
        q_temp <= data;
    end
end

// Logic for advancing by one time step each clock cycle
always @ (posedge clk) begin
    q[0] <= (q_temp[1] ^ q_temp[511] ^ q_temp[0]);
    for (int i = 1; i < 511; i = i + 1) begin
        q[i] <= (q_temp[i + 1] ^ q_temp[i - 1] ^ q_temp[i]);
    end
    q[511] <= (q_temp[0] ^ q_temp[510] ^ q_temp[511]);
    q_temp <= q;
end

endmodule
