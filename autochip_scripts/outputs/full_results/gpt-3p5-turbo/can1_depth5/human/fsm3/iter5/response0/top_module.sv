module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] current_state, next_state;
	reg out_reg;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= 2'b00; // Reset to state A
		end else begin
			current_state <= next_state;
		end
	end

	always @(*) begin
		case (current_state)
			2'b00: begin
				if (in) begin
					next_state = 2'b01; // Next state is B
				end else begin
					next_state = 2'b10; // Next state is C
				end
				out_reg = 1'b0; // Output is 0
			end
			2'b01: begin
				if (in) begin
					next_state = 2'b10; // Next state is C
				end else begin
					next_state = 2'b01; // Next state is B
				end
				out_reg = 1'b0; // Output is 0
			end
			2'b10: begin
				if (in) begin
					next_state = 2'b11; // Next state is D
				end else begin
					next_state = 2'b00; // Next state is A
				end
				out_reg = 1'b0; // Output is 0
			end
			2'b11: begin
				if (in) begin
					next_state = 2'b10; // Next state is C
				end else begin
					next_state = 2'b01; // Next state is B
				end
				out_reg = 1'b1; // Output is 1
			end
		endcase
	end

	always @(posedge clk) begin
		out <= out_reg;
	end
	
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        $display("Start of simulation");
        
        // Add initial values for inputs
        clk = 0;
        in = 0;
        areset = 0;
        
        // Wait for areset to stabilize
        #5;
        areset = 1;
        #5;
        areset = 0;
        
        // Test case 1
        in = 0;
        #5;
        in = 1;
        #5;
        in = 0;
        #5;
        in = 1;
        #5;
        in = 0;
        
        // End simulation
        #5;
        $display("End of simulation");
        $finish;
    end
endmodule
