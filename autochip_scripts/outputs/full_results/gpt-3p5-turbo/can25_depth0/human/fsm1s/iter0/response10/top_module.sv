module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
parameter B = 2'b0;
parameter A = 2'b1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B;
    end else begin
        case (state)
            B: begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            A: begin
                if (in) begin
                    state <= A;
                end else begin
                    state <= B;
                end
            end
        endcase
    end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
