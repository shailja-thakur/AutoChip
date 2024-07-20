module top_module(
	input wire clk,
	input wire shift_ena,
	input wire count_ena,
	input wire data,
	output reg [3:0] q);
    
    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {data, q[3:1]}; // shifting data into the register
        end else if (count_ena) begin
            q <= q - 1; // decrementing the register
        end
    end
    
endmodule
