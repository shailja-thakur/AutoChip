module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (in) state <= B;
                else state <= A;
            end
            B: begin
                if (in) state <= B;
                else state <= C;
            end
            C: begin
                if (in) state <= D;
                else state <= A;
            end
            D: begin
                if (in) state <= B;
                else state <= C;
            end
        endcase
    end
end

always @* begin
    out = (state == D);
end

endmodule
