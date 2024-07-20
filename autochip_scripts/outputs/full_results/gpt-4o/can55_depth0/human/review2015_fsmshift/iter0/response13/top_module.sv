module top_module(
	input clk,
	input reset,
	output reg shift_ena);

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b000;
            shift_ena <= 1'b1;
        end else if (count < 3'b100) begin
            count <= count + 1;
            if (count == 3'b011) begin
                shift_ena <= 1'b0;
            end
        end
    end

endmodule
