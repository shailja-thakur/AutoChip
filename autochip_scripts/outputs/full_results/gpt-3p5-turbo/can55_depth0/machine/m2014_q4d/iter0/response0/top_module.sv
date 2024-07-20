module top_module (
    input clk,
    input in,
    output logic out
);
	
    logic previous_out;
    
    // Assign initial value to out
    initial out = 0;
    
    always_ff @(posedge clk) begin
    	previous_out = out;
        out <= in ^ previous_out;
    end
    
endmodule
