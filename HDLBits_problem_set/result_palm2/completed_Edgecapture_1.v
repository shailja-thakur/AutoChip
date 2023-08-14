module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    reg [31:0] state;
    reg [31:0] capture;

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            if (in[state] == 1 and in[state+1] == 0) begin
                capture <= state;
            end
            state <= state+1;
        end
    end

    always @(posedge clk) begin
        out <= capture;
    end

endmodule