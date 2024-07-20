module top_module (
	input clk,
	input in,
	output logic out
);

always_ff @(posedge clk) begin
    out <= in ^ out;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    
    // Testbench code
    clk = 0;
    in = 0;
    
    // Reset initial output value to 0
    out = 0;
    
    // Toggle input and clock for 100 times
    repeat (100) begin
        #5 clk = ~clk;
        #5 in = ~in;
    end
    
    $finish;
end

endmodule
