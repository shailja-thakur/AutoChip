module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state, next_state;

// State encoding
localparam [1:0] 
    A = 2'b00,
    B = 2'b01,
    C = 2'b10,
    D = 2'b11;

// State transition logic
always @(*) begin
    case (state)
        A: next_state = (in) ? B : A;
        B: next_state = (in) ? B : C;
        C: next_state = (in) ? D : A;
        D: next_state = (in) ? B : C;
    endcase
end

// Output logic
assign out = (state == D);

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

endmodule
