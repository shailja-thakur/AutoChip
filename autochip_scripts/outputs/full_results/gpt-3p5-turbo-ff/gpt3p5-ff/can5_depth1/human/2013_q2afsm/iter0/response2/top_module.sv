module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

reg [1:0] state, next_state; // Registers to store current and next state

// Define states using parameters
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define outputs using parameters
reg g1, g2, g3;

// State transition and output logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A; // Reset to state A
    end else begin
        state <= next_state; // Update current state with next state
    end
end

always @(state or r) begin
    case (state)
        A: begin
            if (r[2] & ~r[1] & ~r[0]) begin // State A to A
                next_state = A;
            end else if (r[1] & ~r[0]) begin // State A to B
                next_state = B;
            end else if (~r[2] & r[1] & ~r[0]) begin // State A to C
                next_state = C;
            end else if (~r[2] & ~r[1] & ~r[0]) begin // State A to D
                next_state = D;
            end
        end
        B: begin
            if (g1 & r[1]) begin // State B to B
                next_state = B;
            end else if (g1 & ~r[1]) begin // State B to A
                next_state = A;
            end
        end
        C: begin
            if (g2 & r[2]) begin // State C to C
                next_state = C;
            end else if (g2 & ~r[2]) begin // State C to A
                next_state = A;
            end
        end
        D: begin
            next_state = A; // State D to A
        end
    endcase
end

// Output assignment
always @(state) begin
    case (state)
        A: begin
            g1 = r[1] & ~r[0] & ~r[2];
            g2 = r[2] & ~r[0] & ~r[1];
            g3 = r[0] | (r[1] & r[2]);
        end
        B: begin
            g1 = r[1] & g1;
            g2 = 1'b0;
            g3 = r[0] | (r[2] & g1);
        end
        C: begin
            g1 = 1'b0;
            g2 = r[2] & g2;
            g3 = r[0] | (r[1] & g2);
        end
        D: begin
            g1 = 1'b0;
            g2 = 1'b0;
            g3 = 1'b0;
        end
    endcase
end

// Assign outputs
assign g[2] = g1;
assign g[1] = g2;
assign g[0] = g3;

endmodule
