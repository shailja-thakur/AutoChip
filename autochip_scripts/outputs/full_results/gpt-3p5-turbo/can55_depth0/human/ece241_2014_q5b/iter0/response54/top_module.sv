module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state, next_state;

    parameter A = 2'b00;
    parameter B = 2'b01;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            A: begin
                z = 1'b0;
                case (x)
                    1'b0: next_state = A;
                    1'b1: next_state = B;
                endcase
            end
            B: begin
                z = 1'b0;
                case (x)
                    1'b0: next_state = B;
                    1'b1: next_state = A;
                endcase
            end
        endcase
    end
endmodule
