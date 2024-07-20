module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

    reg q_next;
    always @ (posedge clk) begin
        if (L) begin
            q_next <= R;
        end else if (E) begin
            q_next <= w;
        end else begin
            q_next <= Q;
        end
    end

    always @ (*) begin
        if (L) begin
            Q = R;
        end else if (E) begin
            Q = w;
        end else begin
            Q = q_next;
        end
    end

endmodule
