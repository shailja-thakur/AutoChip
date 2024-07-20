module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

reg [9:0] counter; // declare a register to hold the counter value

always @(posedge clk) begin
    if (load) begin
        counter <= data; // load counter with new value from data port
    end else if (counter != 0) begin
        counter <= counter - 1; // decrement counter by 1 if not already 0
    end
end

assign tc = (counter == 0); // assert tc when counter value is 0

endmodule
