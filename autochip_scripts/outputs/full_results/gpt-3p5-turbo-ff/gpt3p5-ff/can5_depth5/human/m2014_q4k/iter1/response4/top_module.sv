module top_module (
    input wire clk,
    input wire resetn,
    input wire in,
    output reg out
);

    reg [3:0] data;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            data <= 4'b0000;
        else
            data <= {data[2:0], in};
    end

    always @(posedge clk) begin
        out <= data[3];
    end

endmodule
