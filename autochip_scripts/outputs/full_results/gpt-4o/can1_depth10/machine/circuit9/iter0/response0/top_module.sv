module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);
    // Initial condition for q
    initial begin
        q = 3'b000;  // Start with q at 0
    end
    
    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100;  // When a is 1, q is set to 4
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000;  // When a is 0 and q is 6, q is set to 0
            end else begin
                q <= q + 1;  // When a is 0 and q is not 6, q is increased by 1
            end
        end
    end
endmodule
