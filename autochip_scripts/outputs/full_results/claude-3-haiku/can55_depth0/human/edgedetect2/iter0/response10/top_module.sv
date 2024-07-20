module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_prev; // Register to store the previous input

always @(posedge clk) begin
    // Detect edge for each bit
    for (int i = 0; i < 8; i++) begin
        if (~in_prev[i] & in[i]) // Detect 0 to 1 transition
            anyedge[i] <= 1'b1; // Set the output bit
        else
            anyedge[i] <= 1'b0; // Clear the output bit
    end
    
    // Store the current input for the next cycle
    in_prev <= in;
end

endmodule
