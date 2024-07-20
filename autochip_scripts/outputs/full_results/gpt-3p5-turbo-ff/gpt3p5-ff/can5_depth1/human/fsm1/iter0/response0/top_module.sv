module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;

// Define state values
localparam A = 2'b00;
localparam B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B; // Reset to state B when areset is high
    end else begin
        case(state)
            A: begin
                if (in) begin
                    state <= A; // Stay in state A when input is high
                end else begin
                    state <= B; // Transition to state B when input is low
                end
            end
            B: begin
                if (in) begin
                    state <= B; // Stay in state B when input is high
                end else begin
                    state <= A; // Transition to state A when input is low
                end
            end
        endcase
    end
end

always @(state) begin
    case(state)
        A: out = 1'b0; // Output is 0 when in state A
        B: out = 1'b1; // Output is 1 when in state B
    endcase
end

endmodule
