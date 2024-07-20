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
        out <= 1;
    end
    else begin
        case (state)
            B: begin
                out <= 1;
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            A: begin
                out <= 0;
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            default: begin
                state <= B;
                out <= 1;
            end
        endcase
    end
end

endmodule
