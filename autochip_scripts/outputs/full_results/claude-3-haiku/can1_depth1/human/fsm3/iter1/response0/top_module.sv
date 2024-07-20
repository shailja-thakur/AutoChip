module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            next_state = (in) ? B : A;
            out = 1'b0;
        end
        B: begin
            next_state = (in) ? B : C;
            out = 1'b0;
        end
        C: begin
            next_state = (in) ? D : A;
            out = 1'b0;
        end
        D: begin
            next_state = (in) ? B : C;
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

endmodule
