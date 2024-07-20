module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
always_ff @(posedge clk)
begin
	data <= in;
	out <= data;
end

initial
begin
    // Initialize inputs
    clk = 0;
    in = 0;
    
    #5;
    
    // Apply waveform for inputs
    in = 1;
    
    #5;
    
    // Apply waveform for inputs
    in = 0;
    
    #5;
    
    $finish;
end

endmodule
module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
always_ff @(posedge clk)
begin
	data <= in;
	out <= data;
end

initial
begin
    // Initialize inputs
    clk = 0;
    in = 0;
    
    #5;
    
    // Apply waveform for inputs
    in = 1;
    
    #5;
    
    // Apply waveform for inputs
    in = 0;
    
    #5;
    
    $finish;
end

endmodule
