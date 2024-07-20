module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Define the states
typedef enum logic [1:0] {
    A,
    B,
    C,
    D
} state_e;

// Define the signals
reg [1:0] state_reg, state_next;
reg [3:1] g_reg;

// State table
always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state_reg <= A;
        g_reg <= 0;
    end else begin
        state_reg <= state_next;
        g_reg <= r & {r[1], r[2], r[3]};
    end
end

// Combinational circuit
always_comb begin
    case (state_reg)
        A: begin
            if (r[1] == 1) begin
                state_next = B;
            end else if (r[2] == 1) begin
                state_next = C;
            end else if (r[3] == 1) begin
                state_next = D;
            else begin
                state_next = A;
            end
        end

        B: begin
            if (g_reg[1] == 1 && r[1] == 1) begin
                state_next = B;
            end else begin
                state_next = A;
            end
        end

        C: begin
            if (g_reg[2] == 1 && r[2] == 1) begin
                state_next = C;
            end else begin
                state_next = A;
            end
        end

        D: begin
            state_next = A;
        end
    endcase
end

assign g = g_reg;

endmodule
