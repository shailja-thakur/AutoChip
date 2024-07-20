module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
    reg [3:0] sr;
    reg [3:0] next_sr;
    
    always @(posedge clk) begin
        if (~resetn) begin
            sr <= 4'b0;
        end else begin
            next_sr[3:0] = sr[2:0];
            next_sr[0] = in;
            
            sr <= next_sr;
        end
    end
    
    assign out = sr[3];
endmodule
