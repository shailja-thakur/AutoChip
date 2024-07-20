module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

// Declare internal wires
wire [15:0] temp_q;

// Assign temp_q based on the input a
always @(a)
begin
    case(a)
        3'b000: temp_q = 16'h1232;
        3'b001: temp_q = 16'haee0;
        3'b010: temp_q = 16'h27d4;
        3'b011: temp_q = 16'h5a0e;
        3'b100: temp_q = 16'h2066;
        3'b101: temp_q = 16'h64ce;
        3'b110: temp_q = 16'hc526;
        3'b111: temp_q = 16'h2f19;
        default: temp_q = 16'bx;
    endcase
end

// Assign q with temp_q
always @(temp_q)
begin
    q = temp_q;
end

endmodule
