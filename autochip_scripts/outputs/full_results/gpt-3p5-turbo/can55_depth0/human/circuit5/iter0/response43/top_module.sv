module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
    if (a==0 && b==0 && c==0 && d==0 && e==0) begin
        q = 0;
    end else if (a==0 && b==0) begin
        q = b;
    end else if (c==0 && d==0 && e==0) begin
        q = b;
    end else if (c==1 && d==0 && e==0) begin
        q = e;
    end else if (c==2 && d==0 && e==0) begin
        q = a;
    end else if (c==3 && d==0 && e==0) begin
        q = d;
    end else if (c==4 && d==0 && e==0) begin
        q = f;
    end else begin
        q = f;
    end
end

endmodule
