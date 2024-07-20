module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
wire [3:1] g_next;

// State definitions
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// Next state and output assignments
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    g_next = {1'b0, r[3] & ~r[2] & ~r[1], r[3] & r[2] & ~r[1]};
    case (state)
        A: begin
            if (r[1]) begin
                next_state = B;
            end else if (r[2]) begin
                next_state = C;
            end else if (r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (r[1]) begin
                next_state = B;
            end else if (r[2]) begin
                next_state = C;
            end else if (r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        C: begin
            if (r[1]) begin
                next_state = B;
            end else if (r[2]) begin
                next_state = C;
            end else if (r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        D: begin
            if (r[1]) begin
                next_state = B;
            end else if (r[2]) begin
                next_state = C;
            end else if (r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
    endcase
end

// Output assignment
assign g = g_next;

endmodule
