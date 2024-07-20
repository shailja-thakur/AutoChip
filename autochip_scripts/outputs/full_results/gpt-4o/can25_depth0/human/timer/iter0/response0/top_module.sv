module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output reg tc
);

    reg [9:0] counter;
    
    always @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc <= 0;
        end
        else if (counter != 0) begin
            counter <= counter - 1;
            if (counter == 1) 
                tc <= 1;
        end
    end
    
    // Ensure tc remains asserted once counter reaches 0
    always @(posedge clk) begin
        if (!load && counter == 0)
            tc <= 1;
    end

    // Reset counter to 0 at reset time (optional)
    initial begin
        counter = 0;
        tc = 0;
    end

endmodule
