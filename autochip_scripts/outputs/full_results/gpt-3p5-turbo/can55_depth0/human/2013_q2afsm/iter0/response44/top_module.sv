module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define the states using a parameter
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the signals and registers
reg [1:0] state;
reg [3:1] g;

// State table
always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= A;
		g <= 3'b000;
	end else begin
		case (state)
			A: if (r[1] && r[2] && r[3]) begin
					state <= D;
					g <= 3'b000;
				end else if (r[1] && !r[2] && !r[3]) begin
					state <= B;
					g <= 3'b010;
				end else if (!r[1] && r[2] && !r[3]) begin
					state <= C;
					g <= 3'b001;
				end else begin
					state <= A;
					g <= 3'b000;
				end
			B: if(r[1] && g[1]) begin
					state <= B;
					g <= 3'b010;
				end else if (!r[1] && g[1]) begin
					state <= A;
					g <= 3'b000;
				end else begin
					state <= B;
					g <= 3'b010;
				end
			C: if(r[2] && g[2]) begin
					state <= C;
					g <= 3'b001;
				end else if (!r[2] && g[2]) begin
					state <= A;
					g <= 3'b000;
				end else begin
					state <= C;
					g <= 3'b001;
				end
			D: begin
					state <= A;
					g <= 3'b000;
				end
		endcase
	end
end

endmodule
