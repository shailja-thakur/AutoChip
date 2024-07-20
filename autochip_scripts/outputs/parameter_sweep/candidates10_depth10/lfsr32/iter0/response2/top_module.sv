module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

reg [31:0] shift_register;

always @(posedge clk or posedge reset) begin
    if (reset)
        shift_register <= 32'b1;
    else
        shift_register <= {shift_register[30:0], shift_register[31] ^ shift_register[21] ^ shift_register[1] ^ shift_register[0]};
end

assign q = shift_register;

endmodule
