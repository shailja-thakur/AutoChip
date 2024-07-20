module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;
parameter A = 0, B = 1;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
        out <= 1;
    end
    else begin
        case (state)
            B: begin
                if (in == 0) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
                out <= 1;
            end
            A: begin
                if (in == 0) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
                out <= 0;
            end
        endcase
    end
end

endmodule
