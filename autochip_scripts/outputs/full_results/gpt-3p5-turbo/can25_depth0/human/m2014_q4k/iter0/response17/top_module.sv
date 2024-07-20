module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
    reg [3:0] d;
    wire [3:0] q;
    
    // Flop 4
    flop4 flop_inst (
        .clk(clk),
        .resetn(resetn),
        .d(d),
        .q(q)
    );
    
    // Assign input to flop 1
    assign d[0] = in;
    
    // Assign flop outputs to flop inputs
    assign d[1] = q[0];
    assign d[2] = q[1];
    assign d[3] = q[2];
    
    // Assign output to flop 4 output
    assign out = q[3];
    
endmodule
module flop4 (
    input clk,
    input resetn,
    input [3:0] d,
    output reg [3:0] q
);
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            q <= 4'b0;
        end else begin
            q <= d;
        end
    end
    
endmodule
