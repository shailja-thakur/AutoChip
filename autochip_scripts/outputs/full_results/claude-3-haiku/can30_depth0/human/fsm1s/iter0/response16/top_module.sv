module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            A: begin
                if (in == 1'b0) begin
                    state <= B;
                    out <= 1'b0;
                end
                else begin
                    state <= A;
                    out <= 1'b0;
                end
            end
            B: begin
                if (in == 1'b0) begin
                    state <= B;
                    out <= 1'b1;
                end
                else begin
                    state <= B;
                    out <= 1'b1;
                end
            end
            default: begin
                state <= B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
