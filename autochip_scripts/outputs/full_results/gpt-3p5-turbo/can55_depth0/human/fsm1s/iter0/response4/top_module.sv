module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
reg out;

parameter B = 2'b01;
parameter A = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B;
        out <= 1'b1;
    end else begin
        case(state)
            B: begin
                if (in)
                    state <= B;
                else
                    state <= A;
            end
            A: begin
                if (in)
                    state <= A;
                else
                    state <= B;
            end
        endcase

        case(state)
            B: out <= 1'b1;
            A: out <= 1'b0;
        endcase
    end
end

endmodule
