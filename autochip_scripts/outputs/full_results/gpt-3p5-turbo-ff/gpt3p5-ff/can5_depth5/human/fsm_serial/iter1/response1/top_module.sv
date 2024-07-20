module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

	// Define state enumeration
	typedef enum logic [2:0] {
	    IDLE,
	    START_BIT,
	    DATA,
	    STOP_BIT
	} state_t;

	// Define signals
	reg [2:0] state;
	reg [7:0] data;

	// Define signal for current bit position
	reg [2:0] bit_counter;

	// Define next state logic
	always_ff @(posedge clk, posedge reset)
	begin
	    if (reset)
	        state <= IDLE;
	    else
	    begin
	        case (state)
	            IDLE:
	            begin
	                if (in == 0)
	                    state <= START_BIT;
	            end

	            START_BIT:
	            begin
	                state <= DATA;
	                bit_counter <= 0;
	                data <= 0;
	            end

	            DATA:
	            begin
	                if (bit_counter == 7)
	                    state <= STOP_BIT;
	                else
	                    bit_counter <= bit_counter + 1;
	            end

	            STOP_BIT:
	            begin
	                if (in == 1)
	                    state <= IDLE;
	                else
	                    state <= START_BIT; // Corrected to wait for correct stop bit
	            end
	        endcase
	    end
	end

	// Define output logic
	always_comb
	begin
	    done = (state == IDLE); // Set done when FSM returns to idle state
	end

endmodule
