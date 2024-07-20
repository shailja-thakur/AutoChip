module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding in one-hot form
    reg [1:0] state, next_state;
    localparam A = 2'b01, B = 2'b10;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A; // Default to state A if unknown state
        endcase
    end
	
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
	
    // Output logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) z = 1;
               else z = 0;
            B: if (x) z = 0;
               else z = 1;
            default: z = 0;
        endcase
    end

endmodule
