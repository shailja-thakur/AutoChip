module top_module (
    input clk,
    input reset,
    input w,
    output z
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
reg [1:0] state, nstate;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= nstate;
end

always @(state or w) begin
    case (state)
        A: if (w) nstate <= B; else nstate <= A;
        B: if (w) nstate <= C; else nstate <= D;
        C: if (w) nstate <= E; else nstate <= D;
        D: if (w) nstate <= F; else nstate <= A;
        E: if (w) nstate <= E; else nstate <= D;
        F: if (w) nstate <= C; else nstate <= D;
        default: nstate <= A;
    endcase
end

assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
