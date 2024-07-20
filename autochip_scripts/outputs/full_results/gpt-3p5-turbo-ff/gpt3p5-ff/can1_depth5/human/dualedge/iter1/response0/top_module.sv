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
            d_ff1 <= d;
        end else begin
            d_ff2 <= hold_ff;
            q <= d_ff2;
        end
    end
endmodule
