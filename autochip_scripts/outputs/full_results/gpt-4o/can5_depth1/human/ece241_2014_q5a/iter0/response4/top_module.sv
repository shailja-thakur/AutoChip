module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg state;
parameter NEG = 1'b0, POS = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= NEG;
        z <= 0;
    end else begin
        case (state)
            NEG: begin
                if (x == 1'b0) begin
                    z <= 1'b1;
                    state <= NEG;
                end else begin
                    z <= 1'b0;
                    state <= POS;
                end
            end

            POS: begin
                if (x == 1'b0) begin
                    z <= 1'b0;
                    state <= POS;
                end else begin
                    z <= 1'b1;
                    state <= POS;
                end
            end
            
            default: state <= NEG;
        endcase
    end
end

endmodule
