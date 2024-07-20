module top_module (
    input [2:0] in,
    output reg [1:0] out
);

    always @(*) begin
        // Initialize out to 0
        out = 2'b00;
        
        // Count the number of 1's in the input vector
        out = in[0] + in[1] + in[2];
    end

endmodule
