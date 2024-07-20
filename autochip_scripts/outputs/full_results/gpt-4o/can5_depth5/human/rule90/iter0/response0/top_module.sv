module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Create a new array to store the next state
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = 1'b0 ^ q[i+1];  // Boundary condition at the left end
                end else if (i == 511) begin
                    next_q[i] = q[i-1] ^ 1'b0;  // Boundary condition at the right end
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end
            q <= next_q;
        end
    end
    
endmodule
