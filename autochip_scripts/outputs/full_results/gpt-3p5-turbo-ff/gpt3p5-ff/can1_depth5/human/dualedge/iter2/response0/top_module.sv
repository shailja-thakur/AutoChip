module top_module(
    input clk,
    input d,
    output reg q);

    reg d_ff1;
    reg d_ff2;
    reg hold_ff;
    
    always @(posedge clk or negedge clk) begin
        if (clk == 1'b1) begin
            hold_ff <= d;
        end
        d_ff1 <= hold_ff;
        d_ff2 <= d_ff1;
        q <= d_ff2;
    end
endmodule
