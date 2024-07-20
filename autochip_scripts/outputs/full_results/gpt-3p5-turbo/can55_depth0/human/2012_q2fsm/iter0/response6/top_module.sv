module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

// Define the state variable
reg [2:0] state;

// Define the state flip-flops
always @(posedge clk or posedge reset)
    if (reset)
        state <= A;
    else
        case (state)
            A: if (w) state <= B; else state <= A;
            B: if (w) state <= C; else state <= D;
            C: if (w) state <= E; else state <= D;
            D: if (w) state <= F; else state <= A;
            E: if (z) state <= E; else state <= D;
            F: if (z) state <= C; else state <= D;
        endcase

// Define the FSM output z
assign z = (state == E) ? 1'b1 : 1'b0;

endmodule
