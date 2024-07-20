module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;

            // Calculate the next state of each cell
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = q[i+1]; // Boundary condition, q[-1] is zero
                end else if (i == 511) begin
                    next_q[i] = q[i-1]; // Boundary condition, q[512] is zero
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end

            // Update the current state
            q <= next_q;
        end
    end

endmodule
