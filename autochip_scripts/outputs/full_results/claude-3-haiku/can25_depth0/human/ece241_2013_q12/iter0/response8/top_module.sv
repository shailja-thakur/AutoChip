module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

// 8-bit shift register
reg [7:0] Q;

// Shift register logic
always @(posedge clk) begin
    if (enable) begin
        Q <= {Q[6:0], S};
    end
end

// 3-to-8 decoder for address
wire [7:0] address;
assign address = {~A, ~B, ~C};

// Multiplexer for output Z
always @(*) begin
    Z = Q[address];
end

endmodule
