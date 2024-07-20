module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

reg [4:0] feedback;

always @(posedge clk or posedge reset) begin
    if(reset)
        q <= 1;
    else begin
        feedback[4] <= feedback[3];
        feedback[3] <= feedback[2];
        feedback[2] <= feedback[1];
        feedback[1] <= feedback[0];
        feedback[0] <= feedback[4] ^ feedback[2] ^ q;
        q <= feedback[4];
    end
end

endmodule
