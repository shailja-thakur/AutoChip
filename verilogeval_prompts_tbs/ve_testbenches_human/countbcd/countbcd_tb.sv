`timescale 1 ps/1 ps
`define OK 12
`define INCORRECT 13
module reference_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	wire [3:0] enable = { q[11:0]==12'h999, q[7:0]==8'h99, q[3:0] == 4'h9, 1'b1};
	assign ena = enable[3:1];
	always @(posedge clk)
		for (int i=0;i<4;i++) begin
			if (reset || (q[i*4 +:4] == 9 && enable[i]))
				q[i*4 +:4] <= 0;
			else if (enable[i])
				q[i*4 +:4] <= q[i*4 +:4]+1;
		end
	
endmodule


module stimulus_gen (
	input clk,
	output reg reset,
	output reg[511:0] wavedrom_title,
	output reg wavedrom_enable,
	input tb_match
);

	task reset_test(input async=0);
		bit arfail, srfail, datafail;
	
		@(posedge clk);
		@(posedge clk) reset <= 0;
		repeat(3) @(posedge clk);
	
		@(negedge clk) begin datafail = !tb_match ; reset <= 1; end
		@(posedge clk) arfail = !tb_match;
		@(posedge clk) begin
			srfail = !tb_match;
			reset <= 0;
		end
		if (srfail)
			$display("Hint: Your reset doesn't seem to be working.");
		else if (arfail && (async || !datafail))
			$display("Hint: Your reset should be %0s, but doesn't appear to be.", async ? "asynchronous" : "synchronous");
		// Don't warn about synchronous reset if the half-cycle before is already wrong. It's more likely
		// a functionality error than the reset being implemented asynchronously.
	
	endtask


// Add two ports to module stimulus_gen:
//    output [511:0] wavedrom_title
//    output reg wavedrom_enable

	task wavedrom_start(input[511:0] title = "");
	endtask
	
	task wavedrom_stop;
		#1;
	endtask	


	
	initial begin
		reset <= 1;
		reset_test();
		repeat(2) @(posedge clk);
		@(negedge clk);
		wavedrom_start("Counting");
			repeat(12) @(posedge clk);
		@(negedge clk);
		wavedrom_stop();
		repeat(71) @(posedge clk);
		@(negedge clk) wavedrom_start("100 rollover");
			repeat(16) @(posedge clk);
		@(negedge clk) wavedrom_stop();
		repeat(400) @(posedge clk, negedge clk)
			reset <= !($random & 31);
		repeat(19590) @(posedge clk);
		reset <= 1'b1;
		repeat(5) @(posedge clk);
		#1 $finish;
	end
	
endmodule

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_ena;
		int errortime_ena;
		int errors_q;
		int errortime_q;

		int clocks;
	} stats;
	
	stats stats1;
	
	
	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;
	
	reg clk=0;
	initial forever
		#5 clk = ~clk;

	logic reset;
	logic [3:1] ena_ref;
	logic [3:1] ena_dut;
	logic [15:0] q_ref;
	logic [15:0] q_dut;

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(1, stim1.clk, tb_mismatch ,clk,reset,ena_ref,ena_dut,q_ref,q_dut );
	end


	wire tb_match;		// Verification
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.clk,
		.* ,
		.reset );
	reference_module good1 (
		.clk,
		.reset,
		.ena(ena_ref),
		.q(q_ref) );
		
	top_module top_module1 (
		.clk,
		.reset,
		.ena(ena_dut),
		.q(q_dut) );

	
	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	

	
	final begin
		if (stats1.errors_ena) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "ena", stats1.errors_ena, stats1.errortime_ena);
		else $display("Hint: Output '%s' has no mismatches.", "ena");
		if (stats1.errors_q) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "q", stats1.errors_q, stats1.errortime_q);
		else $display("Hint: Output '%s' has no mismatches.", "q");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	// Verification: XORs on the right makes any X in good_vector match anything, but X in dut_vector will only match X.
	assign tb_match = ( { ena_ref, q_ref } === ( { ena_ref, q_ref } ^ { ena_dut, q_dut } ^ { ena_ref, q_ref } ) );
	// Use explicit sensitivity list here. @(*) causes NetProc::nex_input() to be called when trying to compute
	// the sensitivity list of the @(strobe) process, which isn't implemented.
	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		if (ena_ref !== ( ena_ref ^ ena_dut ^ ena_ref ))
		begin if (stats1.errors_ena == 0) stats1.errortime_ena = $time;
			stats1.errors_ena = stats1.errors_ena+1'b1; end
		if (q_ref !== ( q_ref ^ q_dut ^ q_ref ))
		begin if (stats1.errors_q == 0) stats1.errortime_q = $time;
			stats1.errors_q = stats1.errors_q+1'b1; end

	end
endmodule
