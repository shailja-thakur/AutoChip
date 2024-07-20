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
            // Implement Rule 90
            for (int i = 0; i < 512; i = i + 1) begin
                // Left cell
                int left_index = i - 1;
                if (left_index < 0) begin
                    left_index = 0;
                end
                int left = q[left_index];
                
                // Center cell
                int center = q[i];
                
                // Right cell
                int right_index = i + 1;
                if (right_index > 511) begin
                    right_index = 511;
                end
                int right = q[right_index];
                
                // Update center cell's next state
                q[i] <= ~^(left & right);
            end
        end
    end

endmodule
