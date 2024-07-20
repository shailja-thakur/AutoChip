module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    
    reg [3:0] starting_index;

    always @(*) begin
        starting_index = sel * 4;
    end

    assign out = in[starting_index +: 4];
  
endmodule
