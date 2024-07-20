module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	reg fan_on_internal;

	always @(fan_on) begin
		fan_on_internal <= fan_on;
	end

	always @(mode, too_cold, too_hot) begin
		heater = 0;
		aircon = 0;
		fan = 0;

		case(mode)
			1: begin
				if(too_cold)
					heater = 1;

				if(fan_on_internal)
					fan = 1;
			end

			0: begin
				if(too_hot)
					aircon = 1;

				if(fan_on_internal)
					fan = 1;
			end
		endcase
	end
	
endmodule
