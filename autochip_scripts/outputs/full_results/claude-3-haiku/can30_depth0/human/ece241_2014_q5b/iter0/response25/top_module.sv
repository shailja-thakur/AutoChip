module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// State encoding
parameter A = 2'b01;
parameter B = 2'b10;

reg [1:0] state, next_state;

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Next state and output logic
always @(*) begin
    case (state)
        A:
            if (x)
                next_state = B;
            else
                next_state = A;
        B:
            if (x)
                next_state = B;
            else
                next_state = B;
        default:
            next_state = A;
    endcase

    case (state)
        A:
            z = x;
        B:
            z = ~x;
        default:
            z = 1'b0;
    endcase
end

endmodule
