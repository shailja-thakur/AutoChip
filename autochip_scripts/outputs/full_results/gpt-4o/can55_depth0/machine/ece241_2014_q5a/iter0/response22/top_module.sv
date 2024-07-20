module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;

    reg [1:0] state, next_state;

    // State transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            A: if (x) next_state = C; 
               else next_state = A;
            B: if (x) next_state = B; 
               else next_state = C;
            C: if (x) next_state = B; 
               else next_state = C;
            default: next_state = A;
        endcase
    end

    always @(*) begin
        case (state)
            C: z = 1;
            default: z = 0;
        endcase
    end

endmodule
