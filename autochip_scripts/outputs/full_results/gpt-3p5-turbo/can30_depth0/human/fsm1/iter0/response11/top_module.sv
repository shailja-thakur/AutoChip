module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
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

always @(state) begin
    case (state)
        B: out = 1'b0;
        A: out = 1'b1;
    endcase
end

endmodule
