module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    // State encoding using one-hot encoding
    reg [1:0] state, next_state;
    parameter A = 2'b01, B = 2'b10;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

endmodule
