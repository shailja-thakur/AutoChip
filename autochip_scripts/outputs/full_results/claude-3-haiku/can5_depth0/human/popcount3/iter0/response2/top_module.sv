module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Declare an internal signal to store the population count
    reg [1:0] count;

    always @(*) begin
        // Initialize the count to 0
        count = 2'b00;

        // Iterate through the input bits and count the number of '1's
        if (in[0]) count = count + 1'b1;
        if (in[1]) count = count + 1'b1;
        if (in[2]) count = count + 1'b1;
    end

    // Assign the population count to the output
    assign out = count;

endmodule
