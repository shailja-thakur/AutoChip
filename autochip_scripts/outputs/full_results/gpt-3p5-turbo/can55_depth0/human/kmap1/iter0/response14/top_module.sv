module top_module(
	input a, 
	input b,
	input c,
	output out
);
    
    // Define internal wires
    wire empty_wire;
    
    // Implement logic for out port
    assign out = ~empty_wire;
endmodule
