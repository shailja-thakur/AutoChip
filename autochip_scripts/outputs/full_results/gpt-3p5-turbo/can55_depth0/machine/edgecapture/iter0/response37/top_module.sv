module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

    reg [31:0] d_last; // signal to store the previous value of in
	
    always @(posedge clk) begin
        if (reset) begin
            out <= 0; // initialize out to 0 when reset is asserted
            d_last <= 0; // initialize d_last to 0 when reset is asserted
        end else begin
            d_last <= in; // store the previous value of in
            out <= out | (~in & d_last); // modify out based on the input and d_last
        end
    end

endmodule
