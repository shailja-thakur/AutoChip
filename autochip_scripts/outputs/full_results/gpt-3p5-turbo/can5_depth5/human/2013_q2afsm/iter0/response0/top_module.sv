module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Define states
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// Define state register
reg [2:0] state_reg;
reg [2:1] state_next;
assign state_reg = state_next;

// Define output signals
wire g1;
wire g2;
wire g3;

// Combinational logic for output signals
assign g[1] = g1;
assign g[2] = g2;
assign g[3] = g3;

// State transition logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state_next <= A;
    end else begin
        case (state_reg)
            A: begin
                if (r[1] && ~r[2] && ~r[3])
                    state_next <= D;
                else if (r[1])
                    state_next <= B;
                else if (~r[1] && r[2])
                    state_next <= C;
                else
                    state_next <= A;
            end

            B: begin
                if (g1 && r[1])
                    state_next <= B;
                else if (g1 && ~r[1])
                    state_next <= A;
                else
                    state_next <= B;
            end

            C: begin
                if (g2 && r[2])
                    state_next <= C;
                else if (g2 && ~r[2])
                    state_next <= A;
                else
                    state_next <= C;
            end

            D: begin
                state_next <= A;
            end
        endcase
    end
end

// Combinational logic for output signals
always @(*) begin
    case (state_reg)
        A: begin
            g1 = (r[1] && ~r[2] && ~r[3]);
            g2 = 0;
            g3 = 0;
        end

        B: begin
            g1 = (g1 && ~r[1]) ? 1 : 0;
            g2 = 0;
            g3 = 0;
        end

        C: begin
            g1 = 0;
            g2 = (g2 && ~r[2]) ? 1 : 0;
            g3 = 0;
        end

        D: begin
            g1 = 0;
            g2 = 0;
            g3 = 0;
        end
    endcase
end

endmodule
