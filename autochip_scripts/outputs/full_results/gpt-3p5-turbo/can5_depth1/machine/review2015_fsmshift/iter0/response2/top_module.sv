module top_module(
	input clk,
	input reset,
	output shift_ena);
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if(reset) begin
            state <= 3'b000; // B0
        end else if (state == 3'b000) begin
            state <= 3'b001; // B1
        end else if (state == 3'b001) begin
            state <= 3'b010; // B2
        end else if (state == 3'b010) begin
            state <= 3'b011; // B3
        end else if (state == 3'b011) begin
            state <= 3'b100; // Done
        end else begin
            state <= 3'b100; // Done
        end
    end
    
    assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) ? 1'b1 : 1'b0;
    
endmodule
