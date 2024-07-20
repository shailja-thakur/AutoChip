module top_module (
	input clk,
	input areset,
	input x,
	output z
);

    parameter A = 0;
    parameter B = 1;

    reg state;
    reg z;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else begin
            case (state)
                A: begin
                    if (x)
                        state <= B;
                    else
                        state <= A;
                end
                B: state <= B;
                default: state <= A;
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == A && x)
            z <= 1;
        else if (state == B && ~x)
            z <= 1;
        else
            z <= 0;
    end

endmodule
