module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
    reg q_next;
    
    always @(posedge clk) begin
        if (E) begin
            if (L) begin
                Q <= R;
            end else begin
                Q <= q_next;
            end
        end else begin
            Q <= Q;
        end
    end
    
    always @(posedge clk) begin
        if (E) begin
            q_next <= w;
        end else begin
            q_next <= q_next;
        end
    end
endmodule
