module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] Q;
integer select;

always @(posedge clk) begin
	if (enable) begin
		Q[0] <= S;
		Q[1] <= Q[0];
		Q[2] <= Q[1];
		Q[3] <= Q[2];
		Q[4] <= Q[3];
		Q[5] <= Q[4];
		Q[6] <= Q[5];
		Q[7] <= Q[6];
	end
end

always @(A or B or C) begin
	case ({A, B, C})
		3'b000: select = 0;
		3'b001: select = 1;
		3'b010: select = 2;
		3'b011: select = 3;
		3'b100: select = 4;
		3'b101: select = 5;
		3'b110: select = 6;
		3'b111: select = 7;
	endcase
	
	Z <= Q[select];
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    
    enable = 0;
    S = 0;
    A = 0;
    B = 0;
    C = 0;
    
    #10 enable = 1;
    #10 S = 1;
    #10 S = 0;
    
    #10 A = 0;
    #10 B = 0;
    #10 C = 0;
    
    #10 A = 0;
    #10 B = 0;
    #10 C = 1;
    
    #10 A = 0;
    #10 B = 1;
    #10 C = 0;
    
    #10 A = 0;
    #10 B = 1;
    #10 C = 1;
    
    #10 A = 1;
    #10 B = 0;
    #10 C = 0;
    
    #10 A = 1;
    #10 B = 0;
    #10 C = 1;
    
    #10 A = 1;
    #10 B = 1;
    #10 C = 0;
    
    #10 A = 1;
    #10 B = 1;
    #10 C = 1;
    
    #10 $finish;
end

endmodule
