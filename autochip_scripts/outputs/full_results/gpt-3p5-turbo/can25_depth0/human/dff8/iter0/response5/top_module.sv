module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_temp; // temporary storage for the intermediate values of q

// create 8 D flip-flops
always @(posedge clk) begin
    q_temp <= d;
end

// assign the temporary storage to q
assign q = q_temp;

endmodule
