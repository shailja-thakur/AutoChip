module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State parameter definitions
parameter A = 2'b00, B = 2'b01, C = 2'b10;

// State register
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x)
                    state <= C;
                else
                    state <= A;
            end
            B: begin
                if (x)
                    state <= B;
                else
                    state <= C;
            end
            C: begin
                if (x)
                    state <= B;
                else
                    state <= C;
            end
            default:
                state <= A;
        endcase
    end
end

// Output logic
always @(*) begin
    if (state == C)
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
