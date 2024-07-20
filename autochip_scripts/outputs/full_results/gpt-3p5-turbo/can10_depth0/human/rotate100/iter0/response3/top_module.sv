module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    reg [99:0] shift_register;

    always @(posedge clk) begin
        if (load) begin
            shift_register <= data;
        end else if (ena[0] == 1'b1 && ena[1] == 1'b0) begin
            shift_register <= {shift_register[0], shift_register[99:1]};
        end else if (ena[0] == 1'b0 && ena[1] == 1'b1) begin
            shift_register <= {shift_register[1:99], shift_register[0]};
        end
    end

    assign q = shift_register;

endmodule
