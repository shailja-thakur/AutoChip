module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
    parameter A = 0;
    parameter B = 1;

    reg state;

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= B;
        end else if (state == A) begin
            state <= (in == 1'b1) ? A : B;
        end else if (state == B) begin
            state <= (in == 1'b1) ? B : A;
        end
    end

    assign out = (state == B) ? 1'b1 : 1'b0;
endmodule
