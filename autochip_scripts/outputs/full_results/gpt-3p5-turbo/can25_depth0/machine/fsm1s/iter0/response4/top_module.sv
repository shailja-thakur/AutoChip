module top_module (
    input clk,
    input in,
    input reset,
    output out
);

parameter A = 0;
parameter B = 1;

reg [1:0] state;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else begin
        if (state == A) begin
            if (in)
                state <= A;
            else
                state <= B;
        end else begin // state == B
            if (in)
                state <= B;
            else
                state <= A;
        end
    end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
