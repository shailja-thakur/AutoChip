module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
    
    // Registor to store the previous input
    reg prev_d;
    
    always @(posedge clk or posedge ar) begin
        if (ar)
            q <= 0; // Asynchronous reset
        else
            q <= prev_d; // Stores the previous input value
            
        prev_d <= d; // Stores the current input value
    end

endmodule
