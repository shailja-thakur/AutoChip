module top_module (
	input [254:0] in,
	output reg [7:0] out
);

always @(in) begin
    out = 0; // Initialize the output to 0
    
    for (int i = 0; i < 255; i = i + 1) begin
        if (in[i] == 1'b1) begin
            out = out + 1; // Increment the output for each '1' in the input vector
        end
    end
end

endmodule
