`timescale 1 ps/1 ps
`define OK 12
`define INCORRECT 13
module reference_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	logic [9:0] count_value;

	always @(posedge clk)
		if(load) count_value <= data;
		else if(count_value != 0) count_value <= count_value - 1;

	assign tc = count_value == 0;

endmodule

module stimulus_gen(
	input clk, 
	output logic load, 
	output logic [9:0] data, 
	input tb_match,
	output reg[511:0] wavedrom_title,
	output reg wavedrom_enable,
	output int wavedrom_hide_after_time
);


// Add two ports to module stimulus_gen:
//    output [511:0] wavedrom_title
//    output reg wavedrom_enable

	task wavedrom_start(input[511:0] title = "");
	endtask
	
	task wavedrom_stop;
		#1;
	endtask	


	
	initial begin
		load <= 1'b0;
		wavedrom_start("Count 3, then 10 cycles");
			@(posedge clk) {data, load} <= {10'd3, 1'b1};
			@(posedge clk) {data, load} <= {10'hx, 1'b0};
			@(posedge clk) load <= 0;
			@(posedge clk) load <= 0;
			@(posedge clk) load <= 0;
			@(posedge clk) {data, load} <= {10'd10, 1'b1};
			@(posedge clk) {data, load} <= {10'hx, 1'b0};
			repeat(12) @(posedge clk);
		wavedrom_stop();

		@(posedge clk) {load, data} <= {1'b1, 10'h10};
		@(posedge clk) {load, data} <= {1'b0, 10'h10};
		@(posedge clk) {load, data} <= {1'b1, 10'h0};   // Load 0
		@(posedge clk) {load, data} <= {1'b1, 10'h3ff}; // Load 1023
		@(posedge clk) {load, data} <= {1'b0, 10'h0};
		repeat(1040) @(posedge clk);

		repeat(2500) @(posedge clk) begin
			load <= !($urandom & 10'hf);
			data <= $urandom_range(0,32);
		end

		
		#1 $finish;
	end

endmodule
module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_tc;
		int errortime_tc;

		int clocks;
	} stats;
	
	stats stats1;
	
	
	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;
	
	reg clk=0;
	initial forever
		#5 clk = ~clk;

	logic load;
	logic [9:0] data;
	logic tc_ref;
	logic tc_dut;

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(1, stim1.clk, tb_mismatch ,clk,load,data,tc_ref,tc_dut );
	end


	wire tb_match;		// Verification
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.clk,
		.* ,
		.load,
		.data );
	reference_module good1 (
		.clk,
		.load,
		.data,
		.tc(tc_ref) );
		
	top_module top_module1 (
		.clk,
		.load,
		.data,
		.tc(tc_dut) );

	
	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	

	
	final begin
		if (stats1.errors_tc) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "tc", stats1.errors_tc, stats1.errortime_tc);
		else $display("Hint: Output '%s' has no mismatches.", "tc");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	// Verification: XORs on the right makes any X in good_vector match anything, but X in dut_vector will only match X.
	assign tb_match = ( { tc_ref } === ( { tc_ref } ^ { tc_dut } ^ { tc_ref } ) );
	// Use explicit sensitivity list here. @(*) causes NetProc::nex_input() to be called when trying to compute
	// the sensitivity list of the @(strobe) process, which isn't implemented.
	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		if (tc_ref !== ( tc_ref ^ tc_dut ^ tc_ref ))
		begin if (stats1.errors_tc == 0) stats1.errortime_tc = $time;
			stats1.errors_tc = stats1.errors_tc+1'b1; end

	end
endmodule
