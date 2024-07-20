module top_module (
	input clk,
	input in,
	input areset,
	output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b1;
        else begin
            case (state)
                2'b0: begin    // State B
                    if (in)
                        state <= 2'b0;
                    else
                        state <= 2'b1;
                end
                2'b1: begin    // State A
                    if (in)
                        state <= 2'b1;
                    else
                        state <= 2'b0;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b0: out <= 1'b1;    // State B
            2'b1: out <= 1'b0;    // State A
        endcase
    end

endmodule
