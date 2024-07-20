module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @* begin
    if (state == A) begin
        if (j)
            next_state = B;
        else
            next_state = A;
    end
    else begin // state is B
        if (k)
            next_state = A;
        else
            next_state = B;
    end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
