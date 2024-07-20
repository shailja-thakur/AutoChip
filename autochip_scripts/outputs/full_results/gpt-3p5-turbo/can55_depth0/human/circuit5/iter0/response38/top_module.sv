module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	// time            a               b               c               d               e               q
	// 0ns             x               x               x               x               x               x
	// 5ns             x               x               x               x               x               x
	// 10ns            x               x               x               x               x               x
	// 15ns            a               b               0               d               e               b
	// 20ns            a               b               1               d               e               e
	// 25ns            a               b               2               d               e               a
	// 30ns            a               b               3               d               e               d
	// 35ns            a               b               4               d               e               f
	// 40ns            a               b               5               d               e               f
	// 45ns            a               b               6               d               e               f
	// 50ns            a               b               7               d               e               f
	// 55ns            a               b               8               d               e               f
	// 60ns            a               b               9               d               e               f
	// 65ns            a               b               a               d               e               f
	// 70ns            a               b               b               d               e               f
	// 75ns            a               b               c               d               e               f
	// 80ns            a               b               d               d               e               f
	// 85ns            a               b               e               d               e               f
	// 90ns            a               b               f               d               e               f
	
	always @* begin
		case({a,b,c,d,e})
			4'b0000: q = 4'b0010;
			4'b0001: q = 4'b0101;
			4'b0010: q = 4'b0001;
			4'b0011: q = 4'b0011;
			4'b0100: q = 4'b0111;
			4'b0101: q = 4'b0111;
			default: q = 4'b0111;
		endcase
	end

endmodule
