module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'hx;  // Setting the initial value of q to 1'hx
    end
    
    always @(posedge clk) begin
        q <= d;  // Setting the value of q to d at the rising edge of clk
    end

endmodule
