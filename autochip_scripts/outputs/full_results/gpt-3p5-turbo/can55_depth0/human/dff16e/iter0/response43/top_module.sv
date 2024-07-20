module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
    
    reg [7:0] lower_byte;
    reg [7:0] upper_byte;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            lower_byte <= 8'd0;
            upper_byte <= 8'd0;
        end else if (byteena[0]) begin
            lower_byte <= d[7:0];
        end else if (byteena[1]) begin
            upper_byte <= d[15:8];
        end
    end

    always @(posedge clk) begin
        if (~resetn) begin
            q <= 16'd0;
        end else if (byteena[0] && byteena[1]) begin
            q <= d;
        end else if (byteena[0]) begin
            q <= {upper_byte, d[7:0]};
        end else if (byteena[1]) begin
            q <= {d[15:8], lower_byte};
        end
    end

endmodule
