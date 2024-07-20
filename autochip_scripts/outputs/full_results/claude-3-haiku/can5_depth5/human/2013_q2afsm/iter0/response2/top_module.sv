module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

localparam [2:0] 
    A = 3'b000,
    B = 3'b001,
    C = 3'b010,
    D = 3'b011;

reg [2:0] state, next_state;

// State table
always @(*) begin
    case (state)
        A: begin
            if (r[1]) next_state = B;
            else if (r[2]) next_state = C;
            else if (r[3]) next_state = D;
            else next_state = A;
        end
        B: begin
            if (r[1]) next_state = B;
            else next_state = A;
        end
        C: begin
            if (r[2]) next_state = C;
            else next_state = A;
        end
        default: next_state = A; // D state
    endcase
end

// State flip-flops
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= A;
    else
        state <= next_state;
end

// Output logic
assign g[1] = (state == B) && r[1];
assign g[2] = (state == C) && r[2];
assign g[3] = (state == D) && r[3];

endmodule
