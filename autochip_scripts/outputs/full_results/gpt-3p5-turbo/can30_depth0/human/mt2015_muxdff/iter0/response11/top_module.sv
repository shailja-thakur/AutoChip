module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	// Submodule declaration
	// Instantiate the submodule three times
	flipflop ff1(.clk(clk), .D(q_in), .Q(Q_ff1));
	flipflop ff2(.clk(clk), .D(Q_ff1), .Q(Q_ff2));
	mux21 mux(.a(ff2_Q), .b(r_in), .sel(L), .out(Q_mux));

endmodule
module flipflop(
    input clk,
    input D,
    output reg Q);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module mux21(
    input a,
    input b,
    input sel,
    output reg out);

    always @(*) begin
        if (sel) begin
            out <= a;
        end else begin
            out <= b;
        end
    end

endmodule
