module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);
    reg [3:0] sr;
    
    always @(posedge clk) begin
        if (resetn == 0)
            sr <= 4'b0000;
        else begin
            sr <= {sr[2:0], in};
            out <= sr[3];
        end
    end
endmodule
