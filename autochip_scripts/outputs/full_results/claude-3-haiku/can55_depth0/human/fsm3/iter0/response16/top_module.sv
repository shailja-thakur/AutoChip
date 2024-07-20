module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State definitions
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State register
reg [1:0] state, next_state;

// Next state and output logic
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
    endcase
end

// State register update
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

endmodule
