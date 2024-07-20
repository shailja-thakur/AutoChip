module top_module (
	input clk,
	input in,
	output logic out
);

    reg d;
 
    xor2 #(2) xor_inst (
        .a(in),
        .b(out),
        .z(d)
    );
    
    always @(posedge clk) begin
        out <= d;
    end
    
endmodule
