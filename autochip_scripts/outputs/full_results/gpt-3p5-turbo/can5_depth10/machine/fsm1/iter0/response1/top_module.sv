module top_module (
	input clk,
	input in,
	input areset,
	output out
);
    reg state;
    
    always @(posedge clk, posedge areset)
    begin
        if (areset)
            state <= 1'b0;
        else
        begin
            if (state == 1'b0)
            begin
                if (in)
                    state <= 1'b0;
                else
                    state <= 1'b1;
            end
            else
            begin
                if (in)
                    state <= 1'b1;
                else
                    state <= 1'b0;
            end
        end
    end
    
    assign out = (state == 1'b0) ? 1'b0 : 1'b1;
    
endmodule
