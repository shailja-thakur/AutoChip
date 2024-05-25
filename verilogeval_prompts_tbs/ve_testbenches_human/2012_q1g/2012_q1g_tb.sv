`timescale 1 ps/1 ps
`define OK 12
`define INCORRECT 13
module reference_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		case (x) 
			4'h0: f = 1;
			4'h1: f = 1;
			4'h2: f = 0;
			4'h3: f = 0;
			4'h4: f = 1;
			4'h5: f = 1;
			4'h6: f = 1;
			4'h7: f = 0;
			4'h8: f = 0;
			4'h9: f = 0;
			4'ha: f = 0;
			4'hb: f = 0;
			4'hc: f = 1;
			4'hd: f = 0;
			4'he: f = 1;
			4'hf: f = 1;
		endcase
	end

endmodule


module stimulus_gen (
	input clk,
	output logic [4:1] x
);

	initial begin
		repeat(100) @(posedge clk, negedge clk) begin
			x <= $random;
		end
		
		#1 $finish;
	end
	
endmodule

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_f;
		int errortime_f;

		int clocks;
	} stats;
	
	stats stats1;
	
	
	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;
	
	reg clk=0;
	initial forever
		#5 clk = ~clk;

	logic [4:1] x;
	logic f_ref;
	logic f_dut;

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(1, stim1.clk, tb_mismatch ,x,f_ref,f_dut );
	end


	wire tb_match;		// Verification
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.clk,
		.* ,
		.x );
	reference_module good1 (
		.x,
		.f(f_ref) );
		
	top_module top_module1 (
		.x,
		.f(f_dut) );

	
	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	

	
	final begin
		if (stats1.errors_f) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "f", stats1.errors_f, stats1.errortime_f);
		else $display("Hint: Output '%s' has no mismatches.", "f");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	// Verification: XORs on the right makes any X in good_vector match anything, but X in dut_vector will only match X.
	assign tb_match = ( { f_ref } === ( { f_ref } ^ { f_dut } ^ { f_ref } ) );
	// Use explicit sensitivity list here. @(*) causes NetProc::nex_input() to be called when trying to compute
	// the sensitivity list of the @(strobe) process, which isn't implemented.
	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		if (f_ref !== ( f_ref ^ f_dut ^ f_ref ))
		begin if (stats1.errors_f == 0) stats1.errortime_f = $time;
			stats1.errors_f = stats1.errors_f+1'b1; end

	end
endmodule
