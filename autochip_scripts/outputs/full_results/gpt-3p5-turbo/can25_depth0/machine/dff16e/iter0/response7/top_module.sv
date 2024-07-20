module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q);

    reg [15:0] reg_data;

    always @(posedge clk) begin
        if (!resetn) begin
            reg_data <= 16'b0;
        end else begin
            if (byteena[0]) begin
                reg_data[7:0] <= d[7:0];
            end
            if (byteena[1]) begin
                reg_data[15:8] <= d[15:8];
            end
        end
    end

    assign q = reg_data;

endmodule
