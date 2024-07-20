module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] reg_q;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            reg_q <= 5'b1;
        else
            reg_q <= {reg_q[3] ^ reg_q[2], reg_q[4:1]};
    end
    
    assign q = reg_q;
    
endmodule
