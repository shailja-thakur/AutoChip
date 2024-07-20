module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

// Instantiate 8 D flip-flops with active high synchronous reset
reg [7:0] q_internal; // internal register for storing intermediate values
reg [7:0] q_temp; // temporary register for delayed assignment

always @(negedge clk) begin
    if (reset)
        q_internal <= 8'b00110100; // reset to 0x34
    else
        q_internal <= d;
end

initial begin
    q_temp <= 8'b00110100; // initialize q_temp to 0x34
end

always @(negedge clk) begin
    q_temp <= q_internal;
end

assign q = q_temp;

endmodule
