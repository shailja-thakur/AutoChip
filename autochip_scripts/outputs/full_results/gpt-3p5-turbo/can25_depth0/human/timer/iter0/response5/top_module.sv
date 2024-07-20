module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	/* internal counter */
	reg [9:0] counter;
	
	\end{verbatim}

    // initial value of counter is 10'd0
    // whenever load is 1'b1, counter value would be data
    always @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter > 0) begin
            counter <= counter - 1;
        end
    end

    // tc is high when counter value is 0
    assign tc = (counter == 0);

endmodule
