module top_module (
	input [4:1] x,
	output logic f
);

// Intermediate signals
reg d, y;

// Function f
always_comb begin
	case (x)
		4'b0000: begin
			f = d;
		end
		4'b0001: begin
			f = 0;
		end
		4'b0010: begin
			f = d;
		end
		4'b0011: begin
			f = d;
		end
		4'b0100: begin
			f = d;
		end
		4'b0101: begin
			f = 0;
		end
		4'b0110: begin
			f = 1;
		end
		4'b0111: begin
			f = d;
		end
		4'b1000: begin
			f = 1;
		end
		4'b1001: begin
			f = 1;
		end
		4'b1010: begin
			f = 0;
		end
		4'b1011: begin
			f = d;
		end
		4'b1100: begin
			f = 1;
		end
		4'b1101: begin
			f = 1;
		end
		4'b1110: begin
			f = d;
		end
		4'b1111: begin
			f = d;
		end
		default: begin
			f = 1;
		end
	endcase
end

endmodule
