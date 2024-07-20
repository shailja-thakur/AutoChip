module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);
    reg [9:0] counter;
	
    assign tc = (counter == 0);
	
    always @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter != 0) begin
            counter <= counter - 1;
        end
    end
endmodule
