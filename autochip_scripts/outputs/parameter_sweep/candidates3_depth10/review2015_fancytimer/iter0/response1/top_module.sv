module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] delay;
	reg [3:0] state;
	reg [3:0] remaining_time;
	reg start;

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			state <= 4'b0000;
			counting <= 0;
			done <= 0;
		end else begin
			case(state)
				4'b0000: begin
					if(data == 1 && start == 0) begin
						start <= 1;
						state <= 4'b0001;
					end else begin
						start <= 0;
						state <= 4'b0000;
					end
				end
				4'b0001: begin
					if(data == 1 && start == 1) begin
						state <= 4'b0001;
					end else if(data == 0 && start == 1) begin
						delay <= {data, delay[3:1]};
						state <= 4'b0010;
					end else begin
						start <= 0;
						state <= 4'b0000;
					end
				end
				4'b0010: begin
					state <= 4'b0011;
				end
				4'b0011: begin
					counting <= 1;
					count <= delay;
					state <= 4'b0100;
				end
				4'b0100: begin
					if(count > 0) begin
						count <= count - 1;
						remaining_time <= count;
						state <= 4'b0100;
					end else begin
						counting <= 0;
						done <= 1;
						state <= 4'b0101;
					end
				end
				4'b0101: begin
					if(ack == 1) begin
						start <= 0;
						state <= 4'b0000;
					end else begin
						start <= 0;
						state <= 4'b0101;
					end
				end
				default: begin
					state <= 4'b0000;
				end
			endcase
		end
	end
endmodule
