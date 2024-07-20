module top_module (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always@(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        // Create a temporary register to store the next state
        reg [511:0] q_next;
        integer i;

        // Calculate the next state based on Rule 90
        for (i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                q_next[i] = q[i+1] ^ 1'b0; // Considering q[-1] as 0
            end else if (i == 511) begin
                q_next[i] = 1'b0 ^ q[i-1]; // Considering q[512] as 0
            end else begin
                q_next[i] = q[i-1] ^ q[i+1];
            end
        end
        
        // Update the state
        q <= q_next;
    end
end

endmodule
