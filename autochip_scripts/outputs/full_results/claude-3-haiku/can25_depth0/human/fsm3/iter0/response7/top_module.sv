module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State definitions
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

// Next state and output logic
always @(*) begin
    case (state)
        A: begin
            next_state = (in) ? B : A;
            out = 0;
        end
        B: begin
            next_state = (in) ? B : C;
            out = 0;
        end
        C: begin
            next_state = (in) ? D : A;
            out = 0;
        end
        D: begin
            next_state = (in) ? B : C;
            out = 1;
        end
    endcase
end

// State register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
