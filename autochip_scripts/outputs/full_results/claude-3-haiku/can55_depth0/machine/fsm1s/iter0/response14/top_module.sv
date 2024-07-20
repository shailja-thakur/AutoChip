module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 0, B = 1;
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= B; // Reset the state to B
    end
    else begin
        case (state)
            A: begin
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        A: out = 0;
        B: out = 1;
    endcase
end

endmodule
