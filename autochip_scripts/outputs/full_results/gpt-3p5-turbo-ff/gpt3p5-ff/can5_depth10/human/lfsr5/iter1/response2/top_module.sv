module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    reg [4:0] q_temp;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q_temp <= 1;
        else
            q_temp <= {q_temp[3:0], q_temp[4] ^ q_temp[2]};
    end
    
    assign q = q_temp;

endmodule
