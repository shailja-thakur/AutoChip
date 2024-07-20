module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b00xx:
		begin
			f = 0;
		end
		4'b01x1:
		begin
			f = 0;
		end
		4'b01x0:
		begin
			f = 1;
		end
		4'b11x0:
		begin
			f = 1;
		end
		4'b11x1:
		begin
			f = 1;
		end
		4'b111x:
		begin
			f = 1;
		end
		4'b10x1:
		begin
			f = 1;
		end
		default:
		begin
			f = 0;
		end
	endcase
end

endmodule
