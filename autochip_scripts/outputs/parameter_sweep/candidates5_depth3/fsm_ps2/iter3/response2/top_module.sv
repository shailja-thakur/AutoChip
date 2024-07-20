module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [3:0] shift_reg;
reg start_message;
reg [1:0] counter;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		start_message <= 0;
		counter <= 0;
        shift_reg <= 0;
	end
	else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					start_message <= 1;
                    shift_reg <= {shift_reg[2:0], in};
				end
			end
			1: begin
				counter <= counter + 1;
				if (counter == 1) begin
					state <= 2;
                    shift_reg <= {shift_reg[2:0], in};
				end
			end
			2: begin
				if (in[3] == 1) begin
					state <= 3;
					start_message <= 1;
                    shift_reg <= {shift_reg[2:0], in};
				end
			end
            3: begin
                if (counter == 2) begin
                    state <= 0;
                    start_message <= 0;
                    shift_reg <= {shift_reg[2:0], in};
                end else if (in[3] == 1) begin
                    state <= 1;
                    shift_reg <= {shift_reg[2:0], in};
                end
            end
			default: state <= 0;
		endcase
	end
end

assign done = (state == 3) && (counter == 2);

endmodule
