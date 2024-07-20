module top_module(
    input clk,
    input d,
    output reg q);

    reg [1:0] sync;

    always @(posedge clk or negedge clk) begin
        if (clk) begin
            sync[0] <= d;
        end else begin
            sync[1] <= d;
        end
    end

    always @(posedge clk) begin
        q <= sync[0];
    end

    always @(negedge clk) begin
        q <= sync[1];
    end

endmodule
