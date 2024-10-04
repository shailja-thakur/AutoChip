
	always @(*) begin
		case (sel)
			3'h0: out = data0;
			3'h1: out = data1;
			3'h2: out = data2;
			3'h3: out = data3;
			3'h4: out = data4;
			3'h5: out = data5;
			default: out = 4'b0;
		endcase
	end
	
endmodule
