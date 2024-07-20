module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] in_segmented[63:0];
assign in_segmented[0] = in[3:0];
assign in_segmented[1] = in[7:4];
assign in_segmented[2] = in[11:8];
// ...
// Assign all 256 segments in a similar way

always @ (*) begin
    case (sel)
        8'b00000000: out = in_segmented[0];
        8'b00000001: out = in_segmented[1];
        8'b00000010: out = in_segmented[2];
        // ...
        // Define the remaining 253 cases similarly
        default: out = 4'bXXXX; // Handle the case where sel is not in the range [0, 255]
    endcase
end

endmodule
