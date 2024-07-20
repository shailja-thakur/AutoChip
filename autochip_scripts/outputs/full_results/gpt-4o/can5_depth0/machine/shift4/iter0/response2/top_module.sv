module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

always @(posedge clk or posedge areset) begin
    if (areset) 
        q <= 4'b0000; // Asynchronous reset to 0
    else if (load) 
        q <= data; // Load data into register
    else if (ena) 
        q <= {q[2:0], 1'b0}; // Shift left by 1
    // No need for an else; q remains unchanged when no conditions are met
end

endmodule
