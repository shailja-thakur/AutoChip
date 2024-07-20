module top_module(
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;
    reg [512:0] boundary_q; // Increase size to include both boundaries

    // Initialize boundary values
    initial begin
        boundary_q[0] <= 0;
        boundary_q[512] <= 0;
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
            boundary_q[0] <= 0; // Set boundary value
            boundary_q[512] <= 0; // Set boundary value
        end
        else begin
            boundary_q[0] <= q[511]; // Set boundary value based on previous q value
            boundary_q[512] <= q[0]; // Set boundary value based on previous q value
            
            for (int i = 1; i < 512; i = i+1) begin
                next_q[i-1] <= boundary_q[i-1] ^ boundary_q[i+1];
            end

            next_q[511] <= boundary_q[511] ^ boundary_q[1]; // Update the first cell based on the boundary value and the next cell
            next_q[512] <= boundary_q[510] ^ boundary_q[0]; // Update the last cell based on the boundary value and the previous cell

            q <= next_q; // Assign the next state to q
        end
    end
endmodule
