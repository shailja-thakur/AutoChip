module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    reg [31:0] state;
    reg [31:0] d;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            if (in[state] == 1 && in[state+1] == 0) begin
                d <= 1;
            end
            state <= state+1;
        end
    end

    assign out = d;

endmodule