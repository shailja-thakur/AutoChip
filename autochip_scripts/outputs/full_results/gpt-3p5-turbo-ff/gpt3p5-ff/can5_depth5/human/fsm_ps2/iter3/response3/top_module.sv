module top_module (
    input clk,
    input [7:0] in, 
    input reset,
    output reg done
);

reg [2:0] state;
wire flag;

always_ff @(posedge clk or posedge reset) begin
    if(reset)
        state <= 0;
    else if(flag)
        state <= 0;
    else
        state <= state + 1;
end

assign flag = (in[3] == 1) && (state != 0);

always @(posedge clk) begin
    if(state == 3)
        done <= 1;
    else 
        done <= 0;
end

endmodule
