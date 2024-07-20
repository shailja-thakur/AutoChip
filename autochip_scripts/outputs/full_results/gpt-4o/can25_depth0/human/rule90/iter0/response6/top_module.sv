module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
    );
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Create a temporary register to hold the next state
            reg [511:0] next_q;
            integer i;
            
            // Calculate the next state for each cell
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Boundary condition: q[-1] is zero
                    next_q[i] = q[1];
                end else if (i == 511) begin
                    // Boundary condition: q[512] is zero
                    next_q[i] = q[510];
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end
            
            // Update q with the next state
            q <= next_q;
        end
    end
    
endmodule
