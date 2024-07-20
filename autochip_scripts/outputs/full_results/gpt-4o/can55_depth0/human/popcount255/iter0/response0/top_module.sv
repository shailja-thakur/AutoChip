module top_module (
	input [254:0] in,
	output reg [7:0] out
);

    integer i;

    always @(*) begin
        out = 0; // Initialize the output count to zero
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i]; // Add each bit of the input to the count, since 'in[i]' will be 1 if the input bit is '1' and 0 otherwise
        end
    end

endmodule
