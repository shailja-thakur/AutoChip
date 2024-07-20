module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	reg [3:0] state;
	reg [7:0] data;
	reg [2:0] count;
	
	parameter IDLE_STATE = 4'b0000;
	parameter START_STATE = 4'b0001;
	parameter DATA_STATE = 4'b0010;
	parameter STOP_STATE = 4'b0011;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE_STATE;
			data <= 8'b0;
			count <= 3'b0;
		end else begin
			case (state)
				IDLE_STATE: begin
					if (in == 1'b0) begin
						state <= START_STATE;
						data <= 8'b0;
						count <= 3'b0;
					end else begin
						state <= IDLE_STATE;
						data <= 8'b0;
						count <= 3'b0;
					end
				end
				
				START_STATE: begin
					state <= DATA_STATE;
				end
				
				DATA_STATE: begin
					if (count < 3) begin
						data[count] <= in;
						count <= count + 1;
					end else begin
						state <= STOP_STATE;
					end
				end
				
				STOP_STATE: begin
					if (in == 1'b1) begin
						state <= IDLE_STATE;
						done <= 1'b1;
					end else begin
						state <= IDLE_STATE;
						done <= 1'b0;
					end
				end
			endcase
		end
	end
endmodule
