module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always @(*) begin
	case(y)
		6'b000001: begin // A
			Y1 = w; // Y1 is equal to the input w
			Y3 = 1'b0; // Y3 is always 0 in state A
		end
		6'b000010: begin // B
			Y1 = w; // Y1 is equal to the input w
			Y3 = 1'b0; // Y3 is always 0 in state B
		end
		6'b000100: begin // C
			Y1 = w; // Y1 is equal to the input w
			Y3 = 1'b1; // Y3 is always 1 in state C
		end
		6'b001000: begin // D
			Y1 = w; // Y1 is equal to the input w
			Y3 = 1'b0; // Y3 is always 0 in state D
		end
		6'b010000: begin // E
			Y1 = w; // Y1 is equal to the input w
			Y3 = 1'b1; // Y3 is always 1 in state E
		end
		6'b100000: begin // F
			Y1 = w; // Y1 is equal to the input w
			Y3 = 1'b0; // Y3 is always 0 in state F
		end
		default: begin // Default case if y is in an invalid state
			Y1 = 1'b0; // Set Y1 to 0
			Y3 = 1'b0; // Set Y3 to 0
		end
	endcase
end

endmodule
