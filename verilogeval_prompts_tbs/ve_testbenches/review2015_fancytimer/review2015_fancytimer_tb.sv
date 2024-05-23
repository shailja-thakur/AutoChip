`timescale 1 ps/1 ps
`define OK 12
`define INCORRECT 13
`default_nettype none
module reference_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	typedef enum logic[3:0] {
		S, S1, S11, S110, B0, B1, B2, B3, Count, Wait
	} States;
	
	States state, next;
	
	reg shift_ena;
	reg [9:0] fcount;
	reg [3:0] scount;
	wire done_counting = (scount == 0) && (fcount == 999);
	
	always_comb begin
		case (state)
			S: next = States'(data ? S1: S);
			S1: next = States'(data ? S11: S);
			S11: next = States'(data ? S11 : S110);
			S110: next = States'(data ? B0 : S);
			B0: next = B1;
			B1: next = B2;
			B2: next = B3;
			B3: next = Count;
			Count: next = States'(done_counting ? Wait : Count);
			Wait: next = States'(ack ? S : Wait);
			default: next = States'(4'bx);
		endcase
	end
	
	always @(posedge clk) begin
		if (reset) state <= S;
		else state <= next;
	end
		
	always_comb begin
		shift_ena = 0; counting = 0; done = 0;
		if (state == B0 || state == B1 || state == B2 || state == B3)
			shift_ena = 1;
		if (state == Count)
			counting = 1;
		if (state == Wait)
			done = 1;

		if (|state === 1'bx) begin
			{shift_ena, counting, done} = 'x;
		end		
	end
	
	
	// Shift register
	always @(posedge clk) begin
		if (shift_ena)
			scount <= {scount[2:0], data};
		else if (counting && fcount == 999)
			scount <= scount - 1'b1;
	end
	
	// Fast counter
	always @(posedge clk)
		if (!counting)
			fcount <= 10'h0;
		else if (fcount == 999)
			fcount <= 10'h0;
		else
			fcount <= fcount + 1'b1;
	
	assign count = counting ? scount : 'x;
	
	
endmodule


module stimulus_gen (
	input wire clk,
	output reg reset,
	output reg data, 
	output reg ack,
	input wire tb_match,
	input wire counting_dut
);
	bit failed = 0;
	int counting_cycles = 0;
	
	always @(posedge clk, negedge clk)
		if (!tb_match) 
			failed <= 1;
			
	always @(posedge clk)
		if (counting_dut)
			counting_cycles++;
	
	initial begin

		@(posedge clk);
		failed <= 0;
		reset <= 1;
		data <= 0;
		ack <= 1'bx;
		@(posedge clk) 
			data <= 1;
			reset <= 0;
		@(posedge clk) data <= 0;
		@(posedge clk) data <= 0;
		@(posedge clk) data <= 1;
		@(posedge clk) data <= 1;
		@(posedge clk) data <= 0;
		@(posedge clk) data <= 1;
		@(posedge clk) data <= 0;
		@(posedge clk) data <= 0;
		@(posedge clk) data <= 0;
		@(posedge clk) data <= 1;
		@(posedge clk);
			data <= 1'bx;
		repeat(2000) @(posedge clk);
			ack <= 1'b0;
		repeat(3) @(posedge clk);
			ack <= 1'b1;
		@(posedge clk);
			ack <= 1'b0;
			data <= 1'b1;
		if (counting_cycles != 2000)
			$display("Hint: The first test case should count for 2000 cycles. Your circuit counted %0d", counting_cycles);
		counting_cycles <= 0;
		@(posedge clk);
			ack <= 1'bx;
			data <= 1'b1;
		@(posedge clk);
			data <= 1'b0;
		@(posedge clk);
			data <= 1'b1;
		@(posedge clk);	data <= 1'b1;
		@(posedge clk);	data <= 1'b1;
		@(posedge clk);	data <= 1'b1;
		@(posedge clk);	data <= 1'b0;
		repeat(14800) @(posedge clk);
		ack <= 1'b0;
		repeat(400) @(posedge clk);

		if (counting_cycles != 15000)
			$display("Hint: The second test case should count for 15000 cycles. Your circuit counted %0d", counting_cycles);
		counting_cycles <= 0;

		if (failed)
			$display("Hint: Your FSM didn't pass the sample timing diagram posted with the problem statement. Perhaps try debugging that?");
		
		
	
		repeat(1000) @(posedge clk, negedge clk) begin
			reset <= !($random & 8191);
			data <= $random;
			ack <= !($random & 31);
		end
		repeat(100000) @(posedge clk) begin
			reset <= !($random & 8191);
			data <= $random;
			ack <= !($random & 31);
		end

		#1 $finish;
	end
	
endmodule
module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_count;
		int errortime_count;
		int errors_counting;
		int errortime_counting;
		int errors_done;
		int errortime_done;

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
	logic data;
	logic ack;
	logic [3:0] count_ref;
	logic [3:0] count_dut;
	logic counting_ref;
	logic counting_dut;
	logic done_ref;
	logic done_dut;

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(1, stim1.clk, tb_mismatch ,clk,reset,data,ack,count_ref,count_dut,counting_ref,counting_dut,done_ref,done_dut );
	end


	wire tb_match;		// Verification
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.clk,
		.* ,
		.reset,
		.data,
		.ack );
	reference_module good1 (
		.clk,
		.reset,
		.data,
		.ack,
		.count(count_ref),
		.counting(counting_ref),
		.done(done_ref) );
		
	top_module top_module1 (
		.clk,
		.reset,
		.data,
		.ack,
		.count(count_dut),
		.counting(counting_dut),
		.done(done_dut) );

	
	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	

	
	final begin
		if (stats1.errors_count) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "count", stats1.errors_count, stats1.errortime_count);
		else $display("Hint: Output '%s' has no mismatches.", "count");
		if (stats1.errors_counting) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "counting", stats1.errors_counting, stats1.errortime_counting);
		else $display("Hint: Output '%s' has no mismatches.", "counting");
		if (stats1.errors_done) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "done", stats1.errors_done, stats1.errortime_done);
		else $display("Hint: Output '%s' has no mismatches.", "done");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	// Verification: XORs on the right makes any X in good_vector match anything, but X in dut_vector will only match X.
	assign tb_match = ( { count_ref, counting_ref, done_ref } === ( { count_ref, counting_ref, done_ref } ^ { count_dut, counting_dut, done_dut } ^ { count_ref, counting_ref, done_ref } ) );
	// Use explicit sensitivity list here. @(*) causes NetProc::nex_input() to be called when trying to compute
	// the sensitivity list of the @(strobe) process, which isn't implemented.
	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		if (count_ref !== ( count_ref ^ count_dut ^ count_ref ))
		begin if (stats1.errors_count == 0) stats1.errortime_count = $time;
			stats1.errors_count = stats1.errors_count+1'b1; end
		if (counting_ref !== ( counting_ref ^ counting_dut ^ counting_ref ))
		begin if (stats1.errors_counting == 0) stats1.errortime_counting = $time;
			stats1.errors_counting = stats1.errors_counting+1'b1; end
		if (done_ref !== ( done_ref ^ done_dut ^ done_ref ))
		begin if (stats1.errors_done == 0) stats1.errortime_done = $time;
			stats1.errors_done = stats1.errors_done+1'b1; end

	end
endmodule
