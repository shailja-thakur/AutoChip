module top_module (
	input clk,
	input x,
	output z
);
reg [2:0] ff_inputs;
wire [2:0] ff_outputs;
wire z;

// D flip-flops
always @(posedge clk) begin
    ff_inputs <= x;
end

// XOR gate
assign ff_outputs[0] = ff_inputs[0] ^ ff_outputs[0];

// AND gate
assign ff_outputs[1] = ff_inputs[1] & ~ff_outputs[1];

// OR gate
assign ff_outputs[2] = ff_inputs[2] | ~ff_outputs[2];

// XNOR gate
assign z = ~(ff_outputs[0] ^ ff_outputs[1] ^ ff_outputs[2]);

endmodule
