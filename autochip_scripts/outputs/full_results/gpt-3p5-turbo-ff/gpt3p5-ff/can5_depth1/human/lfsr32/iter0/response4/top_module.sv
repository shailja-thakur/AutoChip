module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] register;

always @(posedge clk) begin
    if (reset) begin
        register <= 32'h1;
    end
    else begin
        register <= {register[31]^register[21]^register[1]^register[0], register[31:1]};
    end
end

assign q = register;

endmodule
