module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
    reg [3:0] sr;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0000;
        else
            sr <= {sr[2:0], in};
    end
    
    assign out = sr[0]; // Change from sr[3] to sr[0] to correctly reflect the LSB after shift

endmodule
