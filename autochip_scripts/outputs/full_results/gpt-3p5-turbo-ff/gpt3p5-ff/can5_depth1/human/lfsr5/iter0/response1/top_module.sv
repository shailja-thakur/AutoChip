module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

    reg [4:0] lfsr;
    reg [4:0] next_lfsr;
    wire tap;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 5'b1;
        end else begin
            lfsr <= next_lfsr;
        end
    end
    
    assign tap = lfsr[5]^lfsr[3];
    
    always @* begin
        next_lfsr[4] = tap;
        next_lfsr[3:0] = lfsr[4:1];
    end
    
    assign q = lfsr;

endmodule
