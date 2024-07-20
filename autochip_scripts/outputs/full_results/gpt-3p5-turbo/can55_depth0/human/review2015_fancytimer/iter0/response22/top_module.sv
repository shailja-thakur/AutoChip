module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] delay;
	reg [3:0] count_reg;

	// State definition
	reg [1:0] state;
	parameter [1:0]
	    IDLE = 2'b00,
	    SEARCH_START = 2'b01,
	    SHIFT_IN = 2'b10;

	always @(posedge clk or posedge reset) begin
	    if (reset)
	        state <= IDLE;
	    else begin
	        case (state)
	            IDLE: begin
	                if (data == 1'b1 && $past(data) == 1'b1) // Detect input pattern 1101
	                    state <= SEARCH_START;
	                else
	                    state <= IDLE;
	            end
	            SEARCH_START: begin
	                state <= SHIFT_IN;
	                delay <= 0;
	            end
	            SHIFT_IN: begin
	                if (delay < 4) begin
	                    // Shift in 4 bits from data input
	                    delay <= {delay[2:0], data};
	                    state <= SHIFT_IN;
	                end else begin
	                    counting <= 1'b1;
	                    state <= IDLE; // Counting state
	                end
	            end
	        endcase
	    end
	end

	always @(posedge clk or posedge reset) begin
	    if (reset)
	        count_reg <= 4'b0;
	    else if (state == IDLE)
	        count_reg <= 4'b0;
	    else if (count_reg < (delay + 1))
	        count_reg <= count_reg + 1;
	    else
	        count_reg <= 4'b0;
	end

	always @(posedge clk or posedge reset) begin
	    if (reset)
	        done <= 1'b0;
	    else if (state == IDLE && count_reg == (delay + 1) && ack)
	        done <= 1'b1;
	    else
	        done <= 1'b0;
	end

	assign count = counting ? (delay - count_reg) : 4'b0;

endmodule
