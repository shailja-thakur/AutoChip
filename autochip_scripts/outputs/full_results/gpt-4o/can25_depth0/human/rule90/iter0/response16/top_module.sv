module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    integer i;
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Compute the next state for each cell
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Boundary condition for the first cell
                    next_q[i] = q[1];
                end else if (i == 511) begin
                    // Boundary condition for the last cell
                    next_q[i] = q[510];
                end else begin
                    // Main rule 90 condition
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end
            // Update q with the new state
            q <= next_q;
        end
    end

endmodule
