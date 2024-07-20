module top_module(
	input in,
	output out);
    reg out;

    always @(in)
    begin
        out = in;
    end

endmodule
