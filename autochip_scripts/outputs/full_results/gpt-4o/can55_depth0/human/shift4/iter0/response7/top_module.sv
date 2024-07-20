module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000;  // Reset the shift register to zero on areset
        end else if (load) begin
            q <= data;     // Load data into shift register if load is high
        end else if (ena) begin
            q <= {1'b0, q[3:1]};  // Shift right the shift register if ena is high
        end
    end
    
endmodule
