module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state; // Two-bit state variable

// Define the state encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the next state logic
always @(posedge clk) begin
    if (reset) begin
        state <= A; // Reset the FSM to state A
    end else begin
        case (state)
            A: if (in) state <= B; else state <= A;
            B: if (in) state <= B; else state <= C;
            C: if (in) state <= D; else state <= A;
            D: if (in) state <= B; else state <= C;
        endcase
    end
end

// Define the Moore output logic
always @(state) begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b0;
        C: out = 1'b0;
        D: out = 1'b1;
    endcase
end

endmodule
