module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state; // Define a 2-bit register for the state and the next state
reg out_reg; // Define a register to hold the output value

parameter A = 2'b00; // Define the values for each state
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin // Asynchronous reset
        state <= A; // Reset the state to A
    end
    else begin
        state <= next_state; // Update the state based on the next state
    end
end

always @(state, in) begin
    case (state)
        A: begin
            if (in == 0) begin
                next_state = A; // Next state is A when input is 0
            end
            else begin
                next_state = B; // Next state is B when input is 1
            end
            out_reg = 0; // Output is always 0 in state A
        end
        B: begin
            if (in == 0) begin
                next_state = C; // Next state is C when input is 0
            end
            else begin
                next_state = B; // Next state is B when input is 1
            end
            out_reg = 0; // Output is always 0 in state B
        end
        C: begin
            if (in == 0) begin
                next_state = A; // Next state is A when input is 0
            end
            else begin
                next_state = D; // Next state is D when input is 1
            end
            out_reg = 0; // Output is always 0 in state C
        end
        D: begin
            if (in == 0) begin
                next_state = C; // Next state is C when input is 0
            end
            else begin
                next_state = B; // Next state is B when input is 1
            end
            out_reg = 1; // Output is always 1 in state D
        end
    endcase
end

assign out = out_reg;

endmodule
