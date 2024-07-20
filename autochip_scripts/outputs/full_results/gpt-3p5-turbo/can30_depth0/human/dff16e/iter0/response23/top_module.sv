module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

reg [7:0] lower_byte;
reg [7:0] upper_byte;

always @(posedge clk or negedge resetn)
begin
    if (resetn == 0)
    begin
        lower_byte <= 8'd0;
        upper_byte <= 8'd0;
        q <= 16'd0;
    end
    else if (byteena[0] == 1)
    begin
        lower_byte <= d[7:0];
    end
    else if (byteena[1] == 1)
    begin
        upper_byte <= d[15:8];
    end
    
    q[7:0] <= lower_byte;
    q[15:8] <= upper_byte;
end

endmodule
