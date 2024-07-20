module top_module(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out
);

	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	assign data_out = data;
	assign valid_out = (state == 3'b100);

	always @(posedge clk or posedge rst) begin
		if (rst)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: begin
					counter <= 8'b00000000;
					data <= 8'b00000000;
					state <= 3'b001;
				end
				3'b001: begin
					counter <= counter + 1'b1;
					data <= 8'b00000000;
					if (counter == 8'b11111111)
						state <= 3'b010;
				end
				3'b010: begin
					data <= in;
					state <= 3'b011;
				end
				3'b011: begin
					state <= 3'b100;
				end
				3'b100: begin
					state <= 3'b000;
				end
			endcase
		end
	end

endmodule
