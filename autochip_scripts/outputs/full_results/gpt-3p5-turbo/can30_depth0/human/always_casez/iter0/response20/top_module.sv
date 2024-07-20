module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

    always @(*) begin
        // Iterate over the input vector from least significant bit
        for (int i=0; i<8; i=i+1) begin
            // Check if the current bit is high
            if (in[i] == 1'b1) begin
                // Set the position output to the current index
                pos = i;
                // Break the loop
                break;
            end
        end
        
        // If no bits are high, set the position output to zero
        if (pos == 0) begin
            pos = 0;
        end
    end
    
endmodule
