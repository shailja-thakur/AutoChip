module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    reg [511:0] next_q;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i=0; i<512; i=i+1) begin
                if (i == 0) begin
                    // Handling left boundary
                    next_q[0] <= 0;
                end else if (i == 511) begin
                    // Handling right boundary
                    next_q[511] <= ((q[510] & q[511] & ~q[0]) | (~q[510] & ~q[511] & q[0]));
                end else begin
                    // Updating the state of each cell based on Rule 110
                    next_q[i] <= ((q[i+1] & (q[i] | ~q[i-1])) | (~q[i+1] & (~q[i-1] | q[i])));
                end
            end
        end
    end
    
    always @(posedge clk) begin
        if (!load) begin
            q <= next_q;
        end
    end
    
endmodule
