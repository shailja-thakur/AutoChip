module top_module (
	input [254:0] in,
	output reg [7:0] out
);

// Create a local wire for intermediate signals
wire [7:0] count;

// Instantiate the population count circuit
pop_count_255 pop_count(
    .in(in),
    .count(count)
);

// Assign the output of the population count circuit to the output register
always @ (count)
    out <= count;

endmodule
module pop_count_255 (
    input [254:0] in,
    output [7:0] count
);
    // Implement the population count circuit using a for loop
    integer i;
    
    always @* begin
        count = 0;
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
    end

endmodule
