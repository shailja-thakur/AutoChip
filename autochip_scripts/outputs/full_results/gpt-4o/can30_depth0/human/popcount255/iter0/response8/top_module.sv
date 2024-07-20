module top_module (
    input [254:0] in,
    output reg [7:0] out
);
    integer i;
    
    always @(*) begin
        out = 8'd0;  // Initialize output to zero
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i];  // Add each bit of the input vector to the output
        end
    end

endmodule
