module top_module(
	input clk,
	input reset,
	output reg shift_ena);

    reg [2:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 3'b000;
            shift_ena <= 1'b1;
        end else if (shift_ena) begin
            if (counter < 3'b011) begin
                counter <= counter + 1;
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end

endmodule
