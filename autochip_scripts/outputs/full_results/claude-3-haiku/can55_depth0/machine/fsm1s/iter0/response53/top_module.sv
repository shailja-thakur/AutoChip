module top_module (
    input clk,
    input in,
    input reset,
    output out
);

parameter A = 0, B = 1;
reg [0:0] state;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else begin
        case (state)
            A: state <= (in) ? A : B;
            B: state <= (in) ? B : A;
        endcase
    end
end

assign out = (state == B);

endmodule
