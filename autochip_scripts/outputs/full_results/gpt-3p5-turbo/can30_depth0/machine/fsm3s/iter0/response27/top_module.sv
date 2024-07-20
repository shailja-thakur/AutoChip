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

reg [1:0] state;
reg out_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= A;             // Reset to state A
    end else begin
        case(state)
            A: begin
                if (in) begin
                    state <= B; // Transition to state B if input is 1
                end
                else begin
                    state <= A; // Stay in state A if input is 0
                end
            end
            B: begin
                if (in) begin
                    state <= B; // Stay in state B if input is 1
                end
                else begin
                    state <= C; // Transition to state C if input is 0
                end
            end
            C: begin
                if (in) begin
                    state <= D; // Transition to state D if input is 1
                end
                else begin
                    state <= A; // Transition to state A if input is 0
                end
            end
            D: begin
                if (in) begin
                    state <= B; // Transition to state B if input is 1
                end
                else begin
                    state <= C; // Transition to state C if input is 0
                end
            end
        endcase
    end
end

// Output logic
always @(state) begin
    if (state == D) begin
        out_reg = 1;                // Set output to 1 when in state D
    end
    else begin
        out_reg = 0;
    end
end

assign out = out_reg;

endmodule
