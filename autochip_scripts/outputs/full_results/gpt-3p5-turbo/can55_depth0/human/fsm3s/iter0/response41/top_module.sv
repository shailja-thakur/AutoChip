module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state, next_state;
reg out_reg;

// State definitions
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Next state logic
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
always @(state) begin
    case (state)
        A: out_reg = 1'b0;
        B: out_reg = 1'b0;
        C: out_reg = 1'b0;
        D: out_reg = 1'b1;
    endcase
end

// Next state logic
always @(state, in) begin
    case (state)
        A: next_state = (in) ? B : A;
        B: next_state = (in) ? B : C;
        C: next_state = (in) ? D : A;
        D: next_state = (in) ? B : C;
    endcase
end

// Output register
always @(posedge clk or posedge reset) begin
    if (reset)
        out <= 1'b0;
    else
        out <= out_reg;
end

endmodule
