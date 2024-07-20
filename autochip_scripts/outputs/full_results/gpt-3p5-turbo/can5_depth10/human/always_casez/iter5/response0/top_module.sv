module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    // Initialize pos to a value outside the valid range
    pos = 3'b111;
    
    // Check each bit in the input vector
    for (int i = 0; i < 8; i = i + 1) begin
        if (in[i]) begin
            // Set pos to the index of the first high bit found
            pos = i;
            break;
        end
    end
end

endmodule
