module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always @* begin
        // Initialize output to zero
        out = 0;
        
        // Iterate through the input vector and count the number of '1's
        for (int i = 0; i < 255; i = i + 1) begin
            if (in[i] == 1'b1)
                out = out + 1;
        end
    end
    
endmodule
