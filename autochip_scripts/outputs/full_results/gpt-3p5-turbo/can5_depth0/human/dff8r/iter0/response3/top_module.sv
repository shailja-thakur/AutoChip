module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

reg [7:0] q_temp; // temporary storage for q

always @(posedge clk) begin
    if (reset) begin
        q_temp <= 8'b0; // reset q_temp to zero
    end else begin
        q_temp <= d; // store d into q_temp on positive edge of clk
    end
end

assign q = q_temp; // assign q_temp to q
endmodule
