module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);
	
    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;   // asynchronous reset
        end else begin
            q <= d;      // positive edge triggered
        end
    end
	
endmodule
