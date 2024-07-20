module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always @(*) begin
        integer i; // Declare an integer for the loop index
        out = 0; // Initialize output to 0
        for (i = 0; i < 255; i = i + 1) // Iterate over each bit of the input
            out = out + in[i]; // Add the value of each bit to the output
    end

endmodule
