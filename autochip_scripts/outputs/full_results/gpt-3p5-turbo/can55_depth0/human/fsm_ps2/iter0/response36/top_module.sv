module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define states
	typedef enum logic [1:0] {
	    STATE_IDLE,
	    STATE_BYTE1,
	    STATE_BYTE2,
	    STATE_BYTE3,
	    STATE_DONE
	} state_t;
	
	// Define signals
	reg done;
	reg [1:0] state;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	
	// Synchronous reset
// 	always @(posedge clk or posedge reset) begin
// 	    if (reset) begin
// 	        state <= STATE_IDLE;
// 	        done <= 0;
// 	    end else begin
// 	        case (state)
// 	            STATE_IDLE: begin
// 	                if (in[3]) begin
// 	                    state <= STATE_BYTE1;
// 	                    byte1 <= in;
// 	                end
// 	            end
// 	            STATE_BYTE1: begin
// 	                byte2 <= in;
// 	                state <= STATE_BYTE2;
// 	            end
// 	            STATE_BYTE2: begin
// 	                byte3 <= in;
// 	                state <= STATE_BYTE3;
// 	            end
// 	            STATE_BYTE3: begin
// 	                done <= 1;
// 	                state <= STATE_DONE;
// 	            end
// 	            STATE_DONE: begin
// 	                if (in[3]) begin
// 	                    state <= STATE_BYTE1;
// 	                    byte1 <= in;
// 	                    done <= 0;
// 	                end else begin
// 	                    state <= STATE_IDLE;
// 	                    done <= 0;
// 	                end
// 	            end
// 	        endcase
// 	    end
// 	end
	
	always_ff @(posedge clk or posedge reset) begin
	    if (reset) begin
	        state <= STATE_IDLE;
	        done <= 0;
	    end else begin
	        case (state)
	            STATE_IDLE: begin
	                if (in[3]) begin
	                    state <= STATE_BYTE1;
	                    byte1 <= in;
	                end
	            end
	            STATE_BYTE1: begin
	                byte2 <= in;
	                state <= STATE_BYTE2;
	            end
	            STATE_BYTE2: begin
	                byte3 <= in;
	                state <= STATE_BYTE3;
	            end
	            STATE_BYTE3: begin
	                done <= 1;
	                state <= STATE_DONE;
	            end
	            STATE_DONE: begin
	                if (in[3]) begin
	                    state <= STATE_BYTE1;
	                    byte1 <= in;
	                    done <= 0;
	                end else begin
	                    state <= STATE_IDLE;
	                    done <= 0;
	                end
	            end
	        endcase
	    end
	end
	
endmodule
