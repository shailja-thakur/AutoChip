module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
wire [1:0] next_state;

// State encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Output mapping
assign out = (state == D) ? 1'b1 : 1'b0;

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Next state logic
always @(state or in) begin
    case (state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = C;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
        end
        D: begin
            if (in)
                next_state = B;
            else
                next_state = C;
        end
        default: next_state = A; // default to state A
    endcase
end

endmodule
