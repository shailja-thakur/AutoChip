module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
reg [1:0] state, next_state;
reg [1:0] x_count;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            A: begin
                f <= 1;
                g <= 0;
                x_count <= 0;
            end
            B: begin
                if (x == 1) begin
                    x_count <= x_count + 1;
                end
                else begin
                    x_count <= 0;
                end
            end
            C: begin
                if (y == 1) begin
                    g <= 1;
                end
                else begin
                    g <= 0;
                end
            end
            D: begin
                g <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        A: next_state = (resetn) ? B : A;
        B: next_state = (x_count == 3) ? C : B;
        C: next_state = (y == 1) ? D : C;
        D: next_state = A;
    endcase
end

endmodule
