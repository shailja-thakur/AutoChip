module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Compute next state for each cell
        for (int i = 0; i < 512; i++) begin
            int left, center, right;
            
            // Handle boundary conditions
            if (i == 0) begin
                left = 0;
            end
            else begin
                left = q[i-1];
            end
            
            center = q[i];
            
            if (i == 511) begin
                right = 0;
            end
            else begin
                right = q[i+1];
            end
            
            // Apply Rule 110
            if ((left & center & right) || (left & center & ~right) || (left & ~center & right) || (~left & center & right) || (~left & center & ~right) || (~left & ~center & right)) begin
                q[i] = 1;
            end
            else begin
                q[i] = 0;
            end
        end
    end
end

endmodule
