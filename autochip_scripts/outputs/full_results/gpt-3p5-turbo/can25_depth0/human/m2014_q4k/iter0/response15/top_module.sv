module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

// Define the flop module
module D_flop (
    input clk,
    input resetn,
    input D,
    output reg Q
);

    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            Q <= 1'b0; // Reset the flop to 0 when resetn is active-low
        else
            Q <= D; // Assign the input value to output Q
    end;

endmodule
module shift_register (
    input clk,
    input resetn,
    input [3:0] in,
    output [3:0] out
);

    // D flop instances
    D_flop flop1 (.clk(clk), .resetn(resetn), .D(in[0]), .Q(out[0]));
    D_flop flop2 (.clk(clk), .resetn(resetn), .D(in[1]), .Q(out[1]));
    D_flop flop3 (.clk(clk), .resetn(resetn), .D(in[2]), .Q(out[2]));
    D_flop flop4 (.clk(clk), .resetn(resetn), .D(in[3]), .Q(out[3]));

endmodule
