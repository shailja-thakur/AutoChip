module top_module(
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;
    reg [511:0] boundary_q; // Store boundary values separately

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            boundary_q[0] <= 0; // Set boundary value
            boundary_q[511] <= 0; // Set boundary value
            
            for (int i = 1; i < 511; i = i+1) begin
                next_q[i] <= q[i-1] ^ q[i+1];
            end

            for (int i = 0; i < 512; i = i+1) begin
                q[i] <= next_q[i];
            end

            q[511] <= boundary_q[510] ^ q[0]; // Update the last cell based on the boundary value
            q[0] <= q[1] ^ boundary_q[511]; // Update the first cell based on the boundary value
        end
    end
endmodule
