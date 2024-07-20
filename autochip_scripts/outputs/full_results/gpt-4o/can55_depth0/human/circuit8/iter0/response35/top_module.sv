module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

    reg state;

    always @(posedge clock) begin
        if (state == 1'b0) begin
            if (a == 1'b1) begin
                p <= 1'b1;
            end else begin
                p <= 1'b0;
            end
        end else begin
            p <= 1'b0;
        end
        state <= ~state;
    end

    always @(negedge clock) begin
        q <= p;
    end
endmodule
