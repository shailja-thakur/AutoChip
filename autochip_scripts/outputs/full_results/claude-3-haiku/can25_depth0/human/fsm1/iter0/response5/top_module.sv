module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
localparam [1:0] A = 2'b00, B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                    out <= 1'b0;
                end
            end
            A: begin
                if (in) begin
                    state <= A;
                    out <= 1'b0;
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
