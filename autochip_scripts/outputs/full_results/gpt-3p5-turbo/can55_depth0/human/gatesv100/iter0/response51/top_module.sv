module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
    reg [98:0] temp_both;
    reg [0:99] temp_any;
    reg [99:0] temp_different;
    
    // Calculate out_both
    always @* begin
        temp_both = in[98:0] & in[99:1];
    end
    
    // Calculate out_any
    always @* begin
        temp_any = {in[99], in[0:98]} | in[99:1];
    end
    
    // Calculate out_different
    always @* begin
        temp_different = in[98:0] ^ in[99:0];
        temp_different[99] = in[99] ^ in[0];
    end
    
    // Assign outputs
    assign out_both = temp_both;
    assign out_any = temp_any;
    assign out_different = temp_different;
endmodule
