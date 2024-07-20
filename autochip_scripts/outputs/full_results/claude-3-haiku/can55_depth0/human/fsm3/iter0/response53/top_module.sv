module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State definitions
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State register
reg [1:0] current_state, next_state;

// Next state logic
always @(*) begin
    case (current_state)
        A: next_state = (in) ? B : A;
        B: next_state = (in) ? B : C;
        C: next_state = (in) ? D : A;
        D: next_state = (in) ? B : C;
        default: next_state = A;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

// State register update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

endmodule
