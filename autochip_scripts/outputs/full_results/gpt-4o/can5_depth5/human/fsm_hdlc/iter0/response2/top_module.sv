module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        ONE     = 3'b001,
        TWO     = 3'b010,
        THREE   = 3'b011,
        FOUR    = 3'b100,
        FIVE    = 3'b101,
        SIX     = 3'b110,
        SEVEN   = 3'b111
    } state_t;
    
    state_t current_state, next_state;
    
    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end
 
	always_comb begin
		// Default values
		next_state = current_state;
		disc = 1'b0;
		flag = 1'b0;
		err = 1'b0;
		
		case (current_state)
			IDLE: begin
				if (in == 1'b1)
					next_state = ONE;
				else
					next_state = IDLE;
			end
			ONE: begin
				if (in == 1'b1)
					next_state = TWO;
				else
					next_state = IDLE;
			end
			TWO: begin
				if (in == 1'b1)
					next_state = THREE;
				else
					next_state = IDLE;
			end
			THREE: begin
				if (in == 1'b1)
					next_state = FOUR;
				else
					next_state = IDLE;
			end	
			FOUR: begin
				if (in == 1'b1)
					next_state = FIVE;
				else
					next_state = IDLE;
			end
			FIVE: begin
				if (in == 1'b1)
					next_state = SIX;
				else
					next_state = IDLE;
			end
			SIX: begin
				if (in == 1'b1) begin
					next_state = SEVEN;
					flag = 1'b1; // set flag for 01111110 condition
				end
				else begin
					next_state = IDLE;
					disc = 1'b1; // set discard for 0111110 condition
				end
			end
			SEVEN: begin
				if (in == 1'b1) begin
					next_state = SEVEN;
					err = 1'b1; // set error for 7 or more consecutive 1s
				end
				else 
					next_state = IDLE;
			end
			default: 
				next_state = IDLE;
		endcase
	end

	assign disc = (current_state == SIX && next_state == IDLE);
	assign flag = (current_state == SIX && in == 1'b1);
	assign err = (current_state == SEVEN);
    
endmodule
