module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Create a temporary array to store the next state
            reg [511:0] next_q;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Handle left boundary condition
                    next_q[i] = q[i+1]; // q[-1] is considered 0
                end else if (i == 511) begin
                    // Handle right boundary condition
                    next_q[i] = q[i-1]; // q[512] is considered 0
                end else begin
                    // General case for middle cells
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end
            q <= next_q;
        end
    end

endmodule
