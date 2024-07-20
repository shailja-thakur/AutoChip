module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] buffer [2:0];
reg [2:0] state;
reg [23:0] out;
wire search_done;
wire [7:0] byte;
assign byte = in[7:0];

// Initialize the module
initial begin
	state = 0;
	buffer[0] = 0;
	buffer[1] = 0;
	buffer[2] = 0;
	out = 0;
	done = 0;
end

// State machine
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		buffer[0] <= 0;
		buffer[1] <= 0;
		buffer[2] <= 0;
		out <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin
				if (byte[3]) begin
					buffer[0] <= byte;
					state <= 1;
				end
			end
			1: begin
				buffer[1] <= byte;
				state <= 2;
			end
			2: begin
				buffer[2] <= byte;
				state <= 3;
			end
			3: begin
				out <= {buffer[0], buffer[1], buffer[2]};
				state <= 0;
				done <= 1;
			end
		endcase
	end
end

// Output byte
always @(posedge clk) begin
	if (done) begin
		out_bytes <= out;
	end else begin
		out_bytes <= 0;
	end
end

// Search done signal
assign search_done = (state == 0 && byte[3]);

endmodule
