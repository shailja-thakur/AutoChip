module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter != 10'd0) begin
            counter <= counter - 1;
        end
    end

    always @(*) begin
        tc = (counter == 10'd0);
    end

endmodule
