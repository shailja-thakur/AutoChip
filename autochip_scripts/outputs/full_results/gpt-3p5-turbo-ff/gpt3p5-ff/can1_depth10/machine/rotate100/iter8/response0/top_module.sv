module top_module(
    input clk, 
    input load, 
    input [1:0] ena, 
    input [99:0] data,
    output reg [99:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load data into output register
        end else begin
            if (ena == 2'b01) begin
                q <= {1'b0, q[99:1]}; // Shift q to the left
            end else if (ena == 2'b10) begin
                q <= {q[98:0], 1'b0}; // Shift q to the right
            end
        end
    end
    
    initial begin
        q <= 100'b0; // Initialize q to 0
    end
    
endmodule
