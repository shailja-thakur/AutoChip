module top_module (
	input clk,
	input d,
	input ar,
	output reg q
);
    
    always @(posedge clk or posedge ar) begin
        if (ar)
            q <= 1'b0; // Asynchronous reset
        else
            q <= d; // D flip-flop operation
    end

endmodule
