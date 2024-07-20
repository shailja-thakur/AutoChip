module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg state, next_state;
	
	// State encoding
	localparam A = 1'b0;
	localparam B = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // default to B
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            B: out = 1;
            A: out = 0;
            default: out = 0;
        endcase
    end

endmodule
