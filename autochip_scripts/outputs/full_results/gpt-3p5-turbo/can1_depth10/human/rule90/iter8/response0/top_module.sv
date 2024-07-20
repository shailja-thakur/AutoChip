module top_module(
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;
    reg [511:0] boundary_q; // Store boundary values separately

    always @(posedge clk) begin
        if (load) begin
            q <= data;
            boundary_q[0] <= 0; // Set boundary value
            boundary_q[511] <= 0; // Set boundary value
        end
        else begin
            boundary_q[0] <= q[511]; // Set boundary value based on previous q value
            boundary_q[511] <= q[0]; // Set boundary value based on previous q value
            
            for (int i = 1; i < 511; i = i+1) begin
                next_q[i] <= q[i-1] ^ q[i+1];
            end

            next_q[0] <= q[511] ^ q[1]; // Update the first cell based on the boundary value and the next cell
            next_q[511] <= q[510] ^ q[0]; // Update the last cell based on the boundary value and the previous cell

            q <= next_q; // Assign the next state to q
        end
    end
endmodule
