module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

// State codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State register
reg [1:0] state;

// Next state logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (r[0] & ~r[1] & ~r[2])
                    state <= B;
                else if (~r[0] & r[1] & ~r[2])
                    state <= C;
                else if (~r[0] & ~r[1] & ~r[2])
                    state <= D;
            end
            
            B: begin
                if (g[0] & ~r[0])
                    state <= B;
                else
                    state <= A;
            end
            
            C: begin
                if (g[1] & ~r[1])
                    state <= C;
                else
                    state <= A;
            end
            
            D: begin
                state <= A;
            end
        endcase
    end
end

// Output assignment
always @(state, r) begin
    case (state)
        A: g = 3'b000;
        B: g = 3'b100;
        C: g = 3'b010;
        default: g = 3'b000;
    endcase
end

endmodule
