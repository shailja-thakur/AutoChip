module fsm (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state;

	// states
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (in) begin
						state <= B;
					end
				end
				B: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
				C: begin
					if (in) begin
						state <= D;
					end else begin
						state <= A;
					end
				end
				D: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
				default: state <= A;
			endcase
		end
	end

	always @* begin
		out = (state == D);
	end

endmodule
module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    fsm fsm_inst (
        .clk(clk),
        .in(in),
        .reset(reset),
        .out(out)
    );

endmodule
