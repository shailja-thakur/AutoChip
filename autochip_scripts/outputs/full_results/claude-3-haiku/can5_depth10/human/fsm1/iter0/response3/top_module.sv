module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

// Asynchronous reset to state B
always @(posedge areset) begin
    state <= B;
end

// State transitions
always @(posedge clk) begin
    case (state)
        A: begin
            if (in == 1'b0) begin
                state <= B;
            end else begin
                state <= A;
            end
        end
        B: begin
            if (in == 1'b0) begin
                state <= B;
            end else begin
                state <= A;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
    endcase
end

endmodule
