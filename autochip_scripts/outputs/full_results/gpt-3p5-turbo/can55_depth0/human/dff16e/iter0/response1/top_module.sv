module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
    
    reg [7:0] q_low;
    reg [7:0] q_high;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            q <= 16'd0;
            q_low <= 8'd0;
            q_high <= 8'd0;
        end else begin
            if (byteena[0]) begin
                q_low <= d[7:0];
            end
            if (byteena[1]) begin
                q_high <= d[15:8];
            end
            q <= {q_high, q_low};
        end
    end
endmodule
