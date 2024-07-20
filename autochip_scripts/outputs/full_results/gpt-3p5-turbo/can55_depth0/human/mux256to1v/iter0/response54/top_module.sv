module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] first_sel;
reg [3:0] out_reg;

assign first_sel = sel * 4; 

always @(*) begin
    case(first_sel)
        0: out_reg = in[3:0];
        4: out_reg = in[7:4];
        8: out_reg = in[11:8];
        // Add more cases for remaining selection values...
        default: out_reg = 4'b0;
    endcase
end

assign out = out_reg;

endmodule
