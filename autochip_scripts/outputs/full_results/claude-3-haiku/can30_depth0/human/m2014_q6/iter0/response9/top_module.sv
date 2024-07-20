module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// States
localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11, E = 3'b100, F = 3'b101;

// State registers
reg [2:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (w) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
            z = 0;
        end
        B: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
            z = 0;
        end
        C: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
            z = 0;
        end
        D: begin
            if (w) begin
                next_state = A;
            end
            else begin
                next_state = F;
            end
            z = 0;
        end
        E: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
            z = 1;
        end
        F: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
            z = 1;
        end
    endcase
end

endmodule
