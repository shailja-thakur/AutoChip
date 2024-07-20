module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// State enumeration
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// internal signals
reg [1:0] state_next;
reg [1:0] state_reg;

// state flip-flop
always @(posedge clk or negedge resetn) begin
    if (~resetn)
        state_reg <= A;
    else
        state_reg <= state_next;
end

// state table
always @(state_reg, r) begin
    case (state_reg)
        A: begin
            if (r[1])
                state_next = B;
            else if (r[2])
                state_next = C;
            else if (r[3])
                state_next = D;
            else
                state_next = A;
        end
        B: begin
            if (r[1])
                state_next = B;
            else if (r[2])
                state_next = C;
            else if (r[3])
                state_next = D;
            else
                state_next = A;
        end
        C: begin
            if (r[1])
                state_next = B;
            else if (r[2])
                state_next = C;
            else if (r[3])
                state_next = C;
            else
                state_next = A;
        end
        D: begin
            state_next = A;
        end
    endcase
end

// output assignments
always @(state_reg) begin
    case (state_reg)
        A: begin
            g[1] = (r[1] && ~r[2] && ~r[3]);
            g[2] = (r[2] && ~r[3]);
            g[3] = (r[3]);
        end
        B: begin
            g[1] = (r[1]);
            g[2] = (r[1] && ~r[2] && ~r[3]);
            g[3] = (r[3]);
        end
        C: begin
            g[1] = (r[1]);
            g[2] = (r[2]);
            g[3] = (r[3]);
        end
        D: begin
            g[1] = (r[1]);
            g[2] = (r[2]);
            g[3] = (r[3]);
        end
    endcase
end

endmodule
