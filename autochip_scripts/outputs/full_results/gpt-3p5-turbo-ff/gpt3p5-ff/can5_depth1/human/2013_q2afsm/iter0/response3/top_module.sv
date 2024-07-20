module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state, next_state;

const [3:1] A = 3'b001;
const [3:1] B = 3'b010;
const [3:1] C = 3'b011;
const [3:1] D = 3'b100;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (r[1] & ~r[2] & ~r[3]) begin
                next_state = A;
            end else if (r[1]) begin
                next_state = B;
            end else if (~r[1] & r[2] & ~r[3]) begin
                next_state = C;
            end else if (~r[1] & ~r[2] & ~r[3]) begin
                next_state = D;
            end
        end
        B: begin
            if (state == B && ~r[1]) begin
                next_state = A;
            end else if (r[1] & state != B) begin
                next_state = B;
            end
        end
        C: begin
            if (state == C && ~r[2]) begin
                next_state = A;
            end else if (r[2] & state != C) begin
                next_state = C;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

always @(posedge clk) begin
    if (~resetn) begin
        g <= 3'b000;
    end else begin
        case (state)
            A: begin
                g <= 3'b000;
            end
            B: begin
                g <= (r[1]) ? 3'b100 : 3'b001;
            end
            C: begin
                g <= (r[2]) ? 3'b010 : 3'b001;
            end
            default: begin
                g <= 3'b000;
            end
        endcase
    end
end

endmodule
