module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or data) begin
		// Default next state
		next_state = state;
		
		case(state)
			4'b0000: begin // Initial state
				if(data == 1) begin
					next_state = 4'b0001;
				end
			end
			
			4'b0001: begin // State 1
				if(data == 1) begin
					next_state = 4'b0010;
				end else begin
					next_state = 4'b0000;
				end
			end
			
			4'b0010: begin // State 2
				if(data == 0) begin
					next_state = 4'b0000;
				end else begin
					next_state = 4'b0011;
				end
			end
			
			4'b0011: begin // State 3 (final state)
				if(data == 1) begin
					next_state = 4'b0100;
				end else begin
					next_state = 4'b0000;
				end
			end
			
			4'b0100: begin // State 4 (sequence found)
				next_state = 4'b0100;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if(state == 4'b0100) begin
			start_shifting <= 1;
		end else begin
			start_shifting <= 0;
		end
	end
endmodule
