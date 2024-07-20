module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State definitions
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State transition logic
always @(*) begin
    case (state)
        A: next_state = (in == 1'b0) ? A : B;
        B: next_state = (in == 1'b0) ? C : B;
        C: next_state = (in == 1'b0) ? A : D;
        D: next_state = (in == 1'b0) ? C : B;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

endmodule
