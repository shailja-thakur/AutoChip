module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

localparam [1:0] 
    A = 2'b00,
    B = 2'b01, 
    C = 2'b10,
    D = 2'b11;

reg [1:0] state, next_state;

// State flip-flops
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

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
            next_state = A;
        end
    endcase
end

// Outputs
assign g[1] = (state == B) && r[1];
assign g[2] = (state == C) && r[2];
assign g[3] = (state == D) && r[3];

endmodule
