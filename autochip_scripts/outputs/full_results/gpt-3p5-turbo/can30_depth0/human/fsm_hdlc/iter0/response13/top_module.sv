module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    // Define states
    parameter IDLE = 2'b00;
    parameter STATE1 = 2'b01;
    parameter STATE2 = 2'b10;
	
    // Define signals
    reg [1:0] state;
    reg prev_bit;
    reg [2:0] consecutive_ones;
    reg output_disc;
	
    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            prev_bit <= 1'b0;
            consecutive_ones <= 3'b0;
            output_disc <= 1'b0;
        end else begin
            prev_bit <= in;
			
            if (output_disc) begin
                output_disc <= 1'b0;
            end else if (consecutive_ones == 3'b110) begin
                output_disc <= 1'b1;
            end
        end
    end
	
    // Next state and output logic
    always @(state or prev_bit or consecutive_ones) begin
        case (state)
            IDLE: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
				
                if (prev_bit && in) begin
                    consecutive_ones <= consecutive_ones + 1;
                    state <= STATE1;
                end else begin
                    consecutive_ones <= 3'b0;
                    state <= IDLE;
                end
            end
						
            STATE1: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
				
                if (prev_bit && in) begin
                    consecutive_ones <= consecutive_ones + 1;
                    state <= STATE2;
                end else begin
                    consecutive_ones <= 3'b0;
                    state <= IDLE;
                end
            end
						
            STATE2: begin
                disc <= output_disc;
                flag <= prev_bit && in;
                err <= 1'b0;
				
                if (prev_bit && in) begin
                    if (consecutive_ones == 3'b111) begin
                        err <= 1'b1;
                        state <= IDLE;
                    end else begin
                        consecutive_ones <= consecutive_ones + 1;
                        state <= STATE2;
                    end
                end else begin
                    consecutive_ones <= 3'b0;
                    state <= IDLE;
                end
            end
        endcase
    end
endmodule
