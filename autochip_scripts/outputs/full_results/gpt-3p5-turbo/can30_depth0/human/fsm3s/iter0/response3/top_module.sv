module top_module (
	input clk,
	input in,
	input reset,
	output out
);

    reg [1:0] state;
    reg out_reg;
	
    always @(posedge clk or posedge reset)
    begin
        if (reset) begin
            state <= 2'b00; // Reset to state A
        end
        else begin
            case(state)
                2'b00: begin // State A
                    if (in) begin // Next state in=1
                        state <= 2'b01; // Set next state to B
                        out_reg <= 1'b0; // Set output to 0
                    end
                    else begin // Next state in=0
                        state <= 2'b00; // Set next state to A
                        out_reg <= 1'b0; // Set output to 0
                    end
                end
                
                2'b01: begin // State B
                    if (in) begin // Next state in=1
                        state <= 2'b01; // Set next state to B
                        out_reg <= 1'b0; // Set output to 0
                    end
                    else begin // Next state in=0
                        state <= 2'b10; // Set next state to C
                        out_reg <= 1'b0; // Set output to 0
                    end
                end
                
                2'b10: begin // State C
                    if (in) begin // Next state in=1
                        state <= 2'b11; // Set next state to D
                        out_reg <= 1'b0; // Set output to 0
                    end
                    else begin // Next state in=0
                        state <= 2'b00; // Set next state to A
                        out_reg <= 1'b0; // Set output to 0
                    end
                end
                
                2'b11: begin // State D
                    if (in) begin // Next state in=1
                        state <= 2'b10; // Set next state to C
                        out_reg <= 1'b1; // Set output to 1
                    end
                    else begin // Next state in=0
                        state <= 2'b01; // Set next state to B
                        out_reg <= 1'b0; // Set output to 0
                    end
                end
            endcase
        end
    end
	
	assign out = out_reg;
	
endmodule
