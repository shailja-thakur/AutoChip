module top_module(
	input clk,
	input reset,
	output reg shift_ena);

    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'd4;
            shift_ena <= 1'b1;
        end else begin
            if (state > 0) begin
                state <= state - 1'b1;
                shift_ena <= 1'b1;
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end
    
endmodule
