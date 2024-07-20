module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg [3:0] state, next_state;

// State encoding
localparam A = 4'b0000;
localparam B = 4'b0001;
localparam S0 = 4'b0010;
localparam S1 = 4'b0011;
localparam S10 = 4'b0100;
localparam G1 = 4'b0101;
localparam G2 = 4'b0110;
localparam P0 = 4'b0111;
localparam P1 = 4'b1000;

always @(posedge clk) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state or x) begin
    case (state)
        A: begin
            if (x) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            next_state = S0;
        end
        S0: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S0;
            end
        end
        S1: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S10;
            end
        end
        S10: begin
            if (x) begin
                next_state = G1;
            end else begin
                next_state = S0;
            end
        end
        G1: begin
            if (y) begin
                next_state = P1;
            end else begin
                next_state = G2;
            end
        end
        G2: begin
            if (y) begin
                next_state = P1;
            end else begin
                next_state = P0;
            end
        end
        P0, P1: begin
            next_state = state;
        end
        default: next_state = A;
    endcase
end

// Assign outputs
assign f = (state == B) ? 1'b1 : 1'b0;
assign g = (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;

endmodule
