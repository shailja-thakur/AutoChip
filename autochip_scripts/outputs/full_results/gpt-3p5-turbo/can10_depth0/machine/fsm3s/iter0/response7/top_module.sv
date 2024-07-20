module top_module (
	input clk,
	input in,
	input reset,
	output out
);

    reg [1:0] state;
    wire clk_positive_edge;

    always @(posedge clk)
        clk_positive_edge <= ~clk_positive_edge;

    always @(posedge clk_positive_edge) begin
        if (reset)
            state <= 2'b00; // initialize state to A
        else begin
            case (state)
                2'b00: begin // state A
                    if (in)
                        state <= 2'b01; // change state to B
                    else
                        state <= 2'b00; // remain in state A
                end
                2'b01: begin // state B
                    if (in)
                        state <= 2'b01; // remain in state B
                    else
                        state <= 2'b10; // change state to C
                end
                2'b10: begin // state C
                    if (in)
                        state <= 2'b11; // change state to D
                    else
                        state <= 2'b00; // change state to A
                end
                2'b11: begin // state D
                    if (in)
                        state <= 2'b01; // change state to B
                    else
                        state <= 2'b10; // change state to C
                end
            endcase
        end
    end

    assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
