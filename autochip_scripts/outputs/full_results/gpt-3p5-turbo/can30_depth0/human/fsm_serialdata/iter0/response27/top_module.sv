module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] byte;
reg [3:0] count;

// State values
parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BIT = 2;
parameter STOP_BIT = 3;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= IDLE;
		byte <= 8'h00;
		count <= 4'b0000;
	end
	else begin
		case (state)
			IDLE: begin
				if (in != 1'b1) begin
					byte <= 8'h00;
					count <= 4'b0001;
					state <= START_BIT;
				end
			end
			
			START_BIT: begin
				if (count < 4'b1001) begin
					byte <= {in, byte[7:1]};
					count <= count + 1;
					state <= DATA_BIT;
				end
			end
			
			DATA_BIT: begin
				if (count < 4'b1001) begin
					byte <= {in, byte[7:1]};
					count <= count + 1;
				end
				else begin
					state <= STOP_BIT;
				end
			end
			
			STOP_BIT: begin
				if (in == 1'b1) begin
					out_byte <= byte;
					state <= IDLE;
				end
			end
		endcase
	end
end

assign done = (state == STOP_BIT);

endmodule
