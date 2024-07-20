module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

    reg [1:0] state;
    wire next_out;

	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b0;
		end else begin
			if (state == 2'b00) begin // state A
				if (j) begin
					state <= 2'b01; // next state B
				end
			end else begin // state B
				if (k) begin
					state <= 2'b00; // next state A
				end
			end
		end
	end
	
	assign next_out = (state == 2'b01) ? 1'b1 : 1'b0;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 1'b0;
		end else begin
			out <= next_out;
		end
	end
    
endmodule
