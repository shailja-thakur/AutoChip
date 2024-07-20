module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

// Define the states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Define the state register and next state logic
reg [1:0] state_reg;
reg [1:0] next_state;

// Assign next_state based on current state and input
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= BYTE1;
	end
	else begin
		case(state_reg)
			BYTE1: begin
				if (in[2] == 1'b1)
					next_state <= BYTE2;
				else
					next_state <= BYTE1;
			end
			BYTE2: begin
				if (in[2] == 1'b1)
					next_state <= BYTE3;
				else
					next_state <= BYTE1;
			end
			BYTE3: begin
				if (in[2] == 1'b1)
					next_state <= DONE;
				else
					next_state <= BYTE1;
			end
			DONE: next_state <= BYTE1;
		endcase
	end
end

// Update state_reg with next_state on the rising edge of clk
always @(posedge clk) begin
	state_reg <= next_state;
end

// Register to store the 24-bit output
reg [23:0] out_reg;

// Update out_reg on the rising edge of clk
always @(posedge clk) begin
	if (done)
		out_bytes <= out_reg;
	out_reg <= {out_reg[15:0], in};
end

// Assign done based on state_reg
always @(*) begin
	done = (state_reg == DONE);
end
    
endmodule
