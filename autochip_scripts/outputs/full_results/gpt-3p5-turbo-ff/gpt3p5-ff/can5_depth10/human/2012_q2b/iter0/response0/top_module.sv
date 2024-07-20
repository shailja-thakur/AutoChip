module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg [5:0] y_next;
always @ (y, w)
begin
	case (y)
		6'd0: y_next = 6'd1;
		6'd1: y_next = 6'd2;
		6'd2: y_next = 6'd4;
		6'd3: y_next = 6'd8;
		6'd4: y_next = 6'd16;
		6'd5: y_next = 6'd8;
		default: y_next = 6'd0;
	endcase
	
	if (~w)
		y_next[0] = y[0];
	
	y <= y_next;
end

assign Y1 = y[1];
assign Y3 = y[3];

endmodule
