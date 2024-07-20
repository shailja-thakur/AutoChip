module top_module (
    input [254:0] in,
    output reg [7:0] out
);
    
    // Combinational logic block
    always @(*) begin
        // Initialize output to zero
        out = 0;
        
        // Loop through each bit of input and sum them up
        integer i;
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end

endmodule
