module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] lfsr;
  
    always @(posedge clk) begin
        if (reset) begin
            lfsr <= 32'b1;
            q <= 32'b1;
        end else begin
            lfsr <= {lfsr[0]^lfsr[19]^lfsr[29]^lfsr[31], lfsr[31:1]};
            q <= lfsr;
        end
    end
endmodule
