module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_temp, q_temp;

always @(posedge clock) begin
    p_temp <= a;
    q_temp <= p_temp;
end

always @(posedge clock) begin
    if (a == 1'b1 && p_temp == 1'b1 && q_temp == 1'b0) begin
        p <= 1'b1;
    end else if (a == 1'b0 && p_temp == 1'b1 && q_temp == 1'b1) begin
        p <= 1'b0;
    end
end

always @(posedge clock) begin
    if (a == 1'b1 && p_temp == 1'b1 && q_temp == 1'b0) begin
        q <= 1'b0;
    end else if (a == 1'b0 && p_temp == 1'b1 && q_temp == 1'b1) begin
        q <= 1'b1;
    end
end

endmodule
