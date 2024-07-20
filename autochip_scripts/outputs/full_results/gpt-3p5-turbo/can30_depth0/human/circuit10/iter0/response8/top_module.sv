module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk) begin
    if (state == 0) begin
        if (a == 0 && b == 0)
            q <= 0;
        else if (a == 0 && b == 1)
            q <= 1;
        else if (a == 1 && b == 0)
            q <= 1;
        else if (a == 1 && b == 1)
            q <= 0;
    end
    else if (state == 1) begin
        q <= 1;
    end
end

always @(posedge clk) begin
    if (state == 0) begin
        if (a == 0 && b == 0)
            state <= 0;
        else if (a == 0 && b == 1)
            state <= 0;
        else if (a == 1 && b == 0)
            state <= 0;
        else if (a == 1 && b == 1)
            state <= 1;
    end
    else if (state == 1) begin
        state <= 0;
    end
end

assign q = q;

endmodule
