module top_module(
	input wire clk,
    input wire rst,
	output wire data_out,
    output wire valid);
    
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	assign out = data_out;
	
	// state definitions
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE;
			counter <= 0;
			data <= 0;
		end else begin
			case (state)
				IDLE: begin
					state <= WAIT;
					counter <= 0;
					data <= 0;
				end
				WAIT: begin
					counter <= counter + 1;
					data <= 0;
					if (counter >= 100) begin
						state <= PROCESS;
					end
				end
				PROCESS: begin
					data <= in;
					state <= DONE;
				end
				DONE: begin
					data <= 0;
					valid <= 1;
					state <= IDLE;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (rst) begin
			valid <= 0;
		end
	end
	
endmodule
