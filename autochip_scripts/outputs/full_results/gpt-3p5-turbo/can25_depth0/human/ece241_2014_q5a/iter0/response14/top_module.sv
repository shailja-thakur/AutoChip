module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg state;
reg z;
wire xneg; // negative of x
wire xsign; // sign bit of x
wire done; // conversion done

// FSM states
parameter idle = 0;
parameter convert = 1;

// state register
always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= idle;
		z <= 1'b0;
	end else begin
		case (state)
			idle: begin
				if (areset == 1) begin
					state <= convert;
				end
			end
			
			convert: begin
				if (xsign == 1) begin
					state <= idle;
				end
			end
		endcase
	end
end

// assign xneg
assign xneg = ~x + 1;

// assign xsign
assign xsign = x[x - 1]; // assuming x's LSB is x[0]

// assign done
assign done = (state == idle) ? 1'b1 : 1'b0;

// assign z
assign z = (state == convert) ? xneg : 1'b0;

endmodule
