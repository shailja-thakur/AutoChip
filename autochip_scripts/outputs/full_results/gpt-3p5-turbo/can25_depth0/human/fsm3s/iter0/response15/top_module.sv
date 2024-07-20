module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define states
parameter A = 2'b00; 
parameter B = 2'b01; 
parameter C = 2'b10; 
parameter D = 2'b11;

reg [1:0] current_state, next_state;

// Define outputs
reg output_reg;

// Synchronous reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// State transition logic
always @(current_state, in) begin
    case (current_state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
            output_reg = 1'b0;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = C;
            output_reg = 1'b0;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
            output_reg = 1'b0;
        end
        D: begin
            if (in)
                next_state = B;
            else
                next_state = C;
            output_reg = 1'b1;
        end
    endcase
end

// Output assignment
assign out = output_reg;

endmodule
