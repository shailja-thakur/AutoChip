module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
    case ({a, b, c, d, e})
        // When a = b, q is set to b
        {4'b0, b} : q = b; 
        // When a <= c, q is set to c
        {a[3], a[2], a[1], a[0], c} : q = c; 
        // When a > c, q is set to a
        {~a[3], ~a[2], ~a[1], ~a[0], d} : q = a; 
        // When a > c and c != d, q is set to d
        {~a[3], ~a[2], ~a[1], c, d} : q = d; 
        // When a > c, c = d, and d != e, q is set to e
        {~a[3], ~a[2], c, d, e} : q = e; 
        // When none of the above conditions are met, q is set to f
        default : q = 4'b1111;
    endcase
end

endmodule
