module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

    always @(posedge clk or posedge areset) begin
        if (areset)
            q <= 4'b0000; // Reset the shift register to zero
        else if (load)
            q <= data; // Load data into shift register
        else if (ena)
            q <= {1'b0, q[3:1]}; // Shift right and q[3] becomes zero
    end

endmodule
