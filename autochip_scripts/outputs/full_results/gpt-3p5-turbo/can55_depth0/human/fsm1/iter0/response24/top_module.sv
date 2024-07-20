module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// state declaration
reg [1:0] state;
parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset)
    if (areset)
        state <= B;
    else
        case(state)
            B: state <= in ? B : A;
            A: state <= in ? A : B;
        endcase

// output assignment
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
