module top_module (
	input clk,
	input in,
	output logic out
);

logic dff;
logic xor_out;

xor2_gate_xor0 u0 (.a(in), .b(out), .o(xor_out)); // Create XOR gate

always@(posedge clk) // Flip-flop positive edge triggered
begin
    dff <= xor_out;
    out <= dff;
end

endmodule
