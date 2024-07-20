module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev; // Register to store previous input value

always @(posedge clk) begin
    in_prev <= in; // Store the current input value in the previous register
    
    // Detect the 0 to 1 transition for each bit and set the output bit accordingly
    for (int i = 0; i < 8; i++) begin
        if (~in_prev[i] & in[i]) // Detect 0 to 1 transition
            pedge[i] <= 1'b1;
        else
            pedge[i] <= 1'b0;
    end
end

endmodule
