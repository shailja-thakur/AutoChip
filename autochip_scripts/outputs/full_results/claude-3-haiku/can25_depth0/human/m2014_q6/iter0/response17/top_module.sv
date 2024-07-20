module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

localparam [3:0] 
    A = 4'b0000,
    B = 4'b0001, 
    C = 4'b0010,
    D = 4'b0011,
    E = 4'b0100,
    F = 4'b0101;

reg [3:0] current_state, next_state;

always @(posedge clk) begin
    if (reset)
        current_state <= A;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        A: begin
            if (w)
                next_state = A;
            else
                next_state = B;
            z = 0;
        end
        B: begin
            if (w)
                next_state = D;
            else
                next_state = C;
            z = 0;
        end
        C: begin
            if (w)
                next_state = D;
            else
                next_state = E;
            z = 0;
        end
        D: begin
            if (w)
                next_state = A;
            else
                next_state = F;
            z = 0;
        end
        E: begin
            if (w)
                next_state = D;
            else
                next_state = E;
            z = 1;
        end
        F: begin
            if (w)
                next_state = D;
            else
                next_state = C;
            z = 1;
        end
        default:
            next_state = A;
    endcase
end

endmodule
