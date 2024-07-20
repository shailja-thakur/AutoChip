module top_module (
	input clk,
	input in,
	input areset,
	output out
);
    
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1'b0;
        else begin
            if (state == 1'b0) begin
                if (in)
                    state <= 1'b0;
                else
                    state <= 1'b1;
            end else begin // state == 1'b1
                if (in)
                    state <= 1'b1;
                else
                    state <= 1'b0;
            end
        end
    end
    
    assign out = state;
    
endmodule
