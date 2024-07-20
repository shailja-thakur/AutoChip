module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    reg [99:0] temp_q;

    always @(posedge clk) begin
        if (load) begin
            temp_q <= data;
        end else if (ena == 2'b01) begin
            temp_q <= temp_q << 1;
        end else if (ena == 2'b10) begin
            temp_q <= temp_q >> 1;
        end
    end

    always @(posedge clk) begin
        q <= temp_q;
    end

endmodule
