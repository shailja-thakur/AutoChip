module top_module(
    input clk,
    input reset,
    output shift_ena);
    
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            shift_ena <= 1'b1;
        end else begin
		case(state)
			3'b000: begin // Initial state
				if (bit_pattern_detected) begin
					state <= 3'b001;
			        shift_ena <= 1'b1;
				end else begin
					state <= 3'b000;
			        shift_ena <= 1'b0;
				end				
			end
			3'b001: begin // Shift enable state
				state <= 3'b010;
			    shift_ena <= 1'b1;
			end
			3'b010: begin // Shift disable state
				state <= 3'b011;
			    shift_ena <= 1'b0;
			end
			3'b011: begin // Shift disable state
				state <= 3'b000;
			    shift_ena <= 1'b0;
			end
			default: begin
				state <= 3'b000;
			    shift_ena <= 1'b0;
			end
		endcase
        end
    end

endmodule
