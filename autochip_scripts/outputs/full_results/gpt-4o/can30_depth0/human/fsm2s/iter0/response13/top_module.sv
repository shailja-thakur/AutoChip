module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

    reg state, next_state;
    
    // State encoding
    parameter OFF = 1'b0, ON = 1'b1;
    
    // State transition
    always @(*) begin
        case(state)
            OFF: if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            ON: if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case(state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
        endcase
    end

endmodule
