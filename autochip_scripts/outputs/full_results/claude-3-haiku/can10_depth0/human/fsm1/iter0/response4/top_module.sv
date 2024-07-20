module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State registers
reg state;
localparam A = 1'b0, B = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else begin
        case (state)
            A: begin
                if (in == 0)
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                if (in == 0)
                    state <= B;
                else
                    state <= A;
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
