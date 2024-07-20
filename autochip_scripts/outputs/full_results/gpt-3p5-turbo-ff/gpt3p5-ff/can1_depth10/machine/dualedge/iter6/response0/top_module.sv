module top_module(
    input clk,
    input d,
    output reg q);

    reg [1:0] sync;

    always @(posedge clk) begin
        sync[0] <= d;
    end

    always @(negedge clk) begin
        sync[1] <= d;
    end

    always @(posedge clk or negedge clk) begin
        if (clk) begin
            q <= sync[0];
        end else begin
            q <= sync[1];
        end
    end

endmodule
