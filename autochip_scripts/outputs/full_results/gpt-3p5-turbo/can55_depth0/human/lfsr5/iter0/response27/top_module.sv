module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] lfsr;
    wire feedback;

    assign feedback = lfsr[4] ^ lfsr[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 5'b1;
        end else begin
            lfsr <= {lfsr[3:0], feedback};
        end
    end

    assign q = lfsr;    
endmodule
