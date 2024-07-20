module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state;
localparam [0:0] A = 0, B = 1;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
        out <= 1;
    end
    else begin
        case (state)
            B: begin
                if (in) begin
                    state <= B;
                    out <= 1;
                end
                else begin
                    state <= A;
                    out <= 1;
                end
            end
            A: begin
                if (in) begin
                    state <= A;
                    out <= 0;
                end
                else begin
                    state <= B;
                    out <= 0;
                end
            end
        endcase
    end
end

endmodule
