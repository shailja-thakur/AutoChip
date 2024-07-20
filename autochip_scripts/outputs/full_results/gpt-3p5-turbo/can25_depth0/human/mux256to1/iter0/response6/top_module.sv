module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] index;
wire [255:0] selected_input;

// Convert sel to binary indexed
always @* begin
    case (sel)
        0: index = 8'b00000001;
        1: index = 8'b00000010;
        2: index = 8'b00000100;
        3: index = 8'b00001000;
        4: index = 8'b00010000;
        5: index = 8'b00100000;
        6: index = 8'b01000000;
        7: index = 8'b10000000;
        default: index = 8'b00000000;
    endcase
end

// Select the input based on the index
assign selected_input = in & index;

// Output the selected input
assign out = |selected_input;

endmodule
