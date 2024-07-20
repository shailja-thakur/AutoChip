module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// States
parameter A = 2'b00;
parameter B = 2'b01;

// State register
reg [1:0] state;

// Next state logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        case (state)
            A: state <= (x) ? B : A;
            B: state <= (x) ? B : B;
        endcase
    end
end

// Output logic
always @(posedge clk) begin
    case (state)
        A: z <= 1'b0;
        B: z <= 1'b1;
    endcase
end

endmodule
