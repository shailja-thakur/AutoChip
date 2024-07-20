module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

// State encoding
localparam [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State registers
reg [1:0] state, next_state;

// State table
always @(*) begin
    next_state = state;
    case (state)
        A: begin
            if (r[1]) next_state = B;
            else if (r[2]) next_state = C;
            else if (r[3]) next_state = D;
        end
        B: begin
            if (r[1]) next_state = B;
            else next_state = A;
        end
        C: begin
            if (r[2]) next_state = C;
            else next_state = A;
        end
        D: begin
            // No transitions from D
        end
    endcase
end

// State flip-flops
always @(posedge clk or negedge resetn) begin
    if (~resetn) state <= A;
    else state <= next_state;
end

// Output logic
always @(*) begin
    g = 3'b000;
    case (state)
        B: g[1] = 1;
        C: g[2] = 1;
        D: g[3] = 1;
    endcase
end

endmodule
