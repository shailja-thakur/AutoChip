module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] count;

    always @(posedge clk) begin
        if (load) begin
            count <= data;
            tc <= 0;
        end else if (count > 0) begin
            count <= count - 1;
            if (count == 1) begin
                tc <= 1;
            end
        end
    end

endmodule
