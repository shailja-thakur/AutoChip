module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
    
    reg [15:0] q_temp;
    reg [15:0] q_temp2;
    
    always @(posedge clk or negedge resetn) begin
        if (resetn == 0) begin
            q_temp <= 16'b0;
            q_temp2 <= 16'b0;
        end else begin
            q_temp <= (byteena[1] == 1'b1) ? {q_temp[15:8], d[15:8]} : {q_temp[15:8], q_temp2[15:8]};
            q_temp2 <= (byteena[0] == 1'b1) ? {q_temp[7:0], d[7:0]} : {q_temp2[7:0], q_temp[7:0]};
        end
    end
    
    always @(posedge clk) begin
        q <= q_temp;
    end
    
endmodule
