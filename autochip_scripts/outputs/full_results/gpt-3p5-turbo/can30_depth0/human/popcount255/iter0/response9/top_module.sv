module population_count (
    input [254:0] in,
    output reg [7:0] out
);

    always @* begin
        out = 0;
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end

endmodule
module top_module (
	input [254:0] in,
	output reg [7:0] out
);

    population_count pc(
        .in(in),
        .out(out)
    );

endmodule
