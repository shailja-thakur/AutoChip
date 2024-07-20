module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    reg [31:0] capture;
    reg [31:0] reset_capture;

    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_in <= 0;
        else
            prev_in <= in;
    end

    always @(posedge clk) begin
        capture <= prev_in & ~in;
        reset_capture <= reset;
    end

    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else
            out <= out | (capture & ~reset_capture);
    end

endmodule
