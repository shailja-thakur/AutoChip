module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State definitions
localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (in) next_state = B;
            else next_state = A;
            out = 0;
        end
        B: begin
            if (in) next_state = B;
            else next_state = C;
            out = 0;
        end
        C: begin
            if (in) next_state = D;
            else next_state = A;
            out = 0;
        end
        D: begin
            if (in) next_state = B;
            else next_state = C;
            out = 1;
        end
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset) state <= A;
    else state <= next_state;
end

endmodule
