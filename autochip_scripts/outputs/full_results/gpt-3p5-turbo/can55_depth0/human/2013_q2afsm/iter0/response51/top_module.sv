module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [3:0] state, next_state;

// Define states
parameter A = 4'b0000;
parameter B = 4'b0001;
parameter C = 4'b0010;
parameter D = 4'b0011;

// Define signals
reg g1, g2, g3;

// State transition logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (r[1] & ~r[2] & ~r[3]) begin
                next_state = A;
            end else if (r[1] & ~r[2] & ~r[3]) begin
                next_state = B;
            end else if (r[1] & r[2] & ~r[3]) begin
                next_state = C;
            end else if (r[1] & ~r[2] & r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (r[1] & g1) begin
                next_state = B;
            end else if (~r[1]) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        C: begin
            if (r[2] & g2) begin
                next_state = C;
            end else if (~r[2]) begin
                next_state = A;
            end else begin
                next_state = C;
            end
        end
        D: begin
            if (r[1] & ~r[2] & ~r[3]) begin
                next_state = A;
            end else begin
                next_state = D;
            end
        end
    endcase
end

// Output assignments
always @(state) begin
    case (state)
        A: begin
            g1 = 1;
            g2 = 0;
            g3 = 0;
        end
        B: begin
            g1 = 0;
            g2 = 0;
            g3 = 0;
        end
        C: begin
            g1 = 0;
            g2 = 1;
            g3 = 0;
        end
        D: begin
            g1 = 0;
            g2 = 0;
            g3 = 0;
        end
    endcase
end

// Assign outputs
assign g = {g3, g2, g1};

endmodule
