module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    reg [3:0] shift_register;

    always @(posedge clk) begin
        if (count_ena == 1'b1)
            shift_register <= shift_register - 1;
        else if (shift_ena == 1'b1)
            shift_register <= {shift_register[2:0], data};
    end

    assign q = shift_register;

endmodule
