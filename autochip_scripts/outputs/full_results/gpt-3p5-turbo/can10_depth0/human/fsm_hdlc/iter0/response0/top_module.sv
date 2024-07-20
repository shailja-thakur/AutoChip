module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg disc_reg, flag_reg, err_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // initial state that behaves as though the previous input were 0
			disc_reg <= 1'b0;
			flag_reg <= 1'b0;
			err_reg <= 1'b0;
		end 
		else begin
			case (state)
				3'b000: begin // State 0
					if (in) begin
						state <= 3'b001;
					end else begin
						state <= 3'b000;
					end
				end
				3'b001: begin // State 1
					if (in) begin
						state <= 3'b010;
					end else begin
						state <= 3'b000;
					end
				end
				3'b010: begin // State 2
					if (in) begin
						state <= 3'b011;
					end else begin
						state <= 3'b000;
					end
				end
				3'b011: begin // State 3
					if (in) begin
						state <= 3'b100;
					end else begin
						state <= 3'b000;
					end
				end
				3'b100: begin // State 4
					if (in) begin
						state <= 3'b101;
					end else begin
						state <= 3'b000;
					end
				end
				3'b101: begin // State 5
					if (in) begin
						state <= 3'b110;
					end else begin
						state <= 3'b000;
					end
				end
				3'b110: begin // State 6
					if (in) begin
						state <= 3'b111;
					end else begin
						state <= 3'b000;
					end
				end
				3'b111: begin // State 7
					if (in) begin
						state <= 3'b111;
					end else begin
						state <= 3'b000;
					end
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case (state)
			3'b000: begin // State 0
				disc_reg <= 1'b0;
				flag_reg <= 1'b0;
				err_reg <= 1'b0;
			end
			3'b001: begin // State 1
				disc_reg <= 1'b0;
				flag_reg <= 1'b0;
				err_reg <= 1'b0;
			end
			3'b010: begin // State 2
				disc_reg <= 1'b0;
				flag_reg <= 1'b0;
				err_reg <= 1'b0;
			end
			3'b011: begin // State 3
				disc_reg <= 1'b0;
				flag_reg <= 1'b0;
				err_reg <= 1'b0;
			end
			3'b100: begin // State 4
				disc_reg <= 1'b0;
				flag_reg <= 1'b0;
				err_reg <= 1'b0;
			end
			3'b101: begin // State 5
				disc_reg <= 1'b1;
				flag_reg <= 1'b0;
				err_reg <= 1'b0;
			end
			3'b110: begin // State 6
				disc_reg <= 1'b0;
				flag_reg <= 1'b1;
				err_reg <= 1'b0;
			end
			3'b111: begin // State 7
				disc_reg <= 1'b0;
				flag_reg <= 1'b0;
				err_reg <= 1'b1;
			end
		endcase
	end

	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;

endmodule
