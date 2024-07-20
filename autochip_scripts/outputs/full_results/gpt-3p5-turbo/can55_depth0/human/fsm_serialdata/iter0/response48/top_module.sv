module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// Define states
	typedef enum logic[2:0] {
		IDLE,
		START,
		BIT1,
		BIT2,
		BIT3,
		BIT4,
		BIT5,
		BIT6,
		BIT7,
		BIT8,
		STOP
	} state_t;
	
	// Define signals
	logic [2:0] state;
	logic [7:0] byte;
	
	// Define next state combinational logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			byte <= 8'h00;
		end else begin
			case (state)
				IDLE: begin
					if (in == 1'b0)
						state <= START;
				end
				START: begin
					state <= BIT1;
				end
				BIT1: begin
					state <= BIT2;
					byte <= {in, byte[7:1]};
				end
				BIT2: begin
					state <= BIT3;
					byte <= {in, byte[7:1]};
				end
				BIT3: begin
					state <= BIT4;
					byte <= {in, byte[7:1]};
				end
				BIT4: begin
					state <= BIT5;
					byte <= {in, byte[7:1]};
				end
				BIT5: begin
					state <= BIT6;
					byte <= {in, byte[7:1]};
				end
				BIT6: begin
					state <= BIT7;
					byte <= {in, byte[7:1]};
				end
				BIT7: begin
					state <= BIT8;
					byte <= {in, byte[7:1]};
				end
				BIT8: begin
					state <= STOP;
					byte <= {in, byte[7:1]};
				end
				STOP: begin
					state <= IDLE;
				end
				default: begin
					state <= IDLE;
				end
			endcase
		end
	end
	
	// Define output logic
	always_comb begin
		done = (state == STOP);
		out_byte = byte;
	end
	
endmodule
