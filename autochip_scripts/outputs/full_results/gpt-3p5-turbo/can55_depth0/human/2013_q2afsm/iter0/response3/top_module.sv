module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

// State codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// State flip-flops
reg [2:0] state;

// Next state logic
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= A;
    else begin
        case (state)
            A: if (r[1] && r[2] && r[3])
                    state <= D;
               else if (r[1])
                    state <= B;
               else if (r[2])
                    state <= C;
               else
                    state <= A;
            B: if (!r[1] && g[1])
                    state <= A;
               else
                    state <= B;
            C: if (!r[2] && g[2])
                    state <= A;
               else
                    state <= C;
            D: if (!r[1] && !r[2] && !r[3])
                    state <= A;
               else
                    state <= D;
        endcase
    end
end

// Output logic
always @(state) begin
    g[1] = (state == B);
    g[2] = (state == C);
    g[3] = (state == A && !(r[1] || r[2] || r[3]));
end

endmodule
