module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
localparam A = 1'b0, B = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= B;
    end
    else begin
        case (state)
            A: if (in) begin
                   state <= A;
               end
               else begin
                   state <= B;
               end
            B: if (in) begin
                   state <= B;
               end
               else begin
                   state <= A;
               end
        endcase
    end
end

always @(*) begin
    out = (state == B);
end

endmodule
