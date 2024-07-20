module top_module (
    input wire clk,
    input wire resetn,
    input wire [3:1] r,
    output reg [3:1] g
);

    // State encoding
    localparam [1:0] S_A = 2'b00,
                     S_B = 2'b01,
                     S_C = 2'b10;

    // State registers
    reg [1:0] state, next_state;

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= S_A;
        else
            state <= next_state;
    end

    // Next state logic (state transitions)
    always @(*) begin
        case (state)
            S_A: begin
                if (r[1])
                    next_state = S_B;
                else if (r[2])
                    next_state = S_C;
                else
                    next_state = S_A;
            end
            S_B: begin
                if (r[1])
                    next_state = S_B;
                else
                    next_state = S_A;
            end
            S_C: begin
                if (r[2])
                    next_state = S_C;
                else
                    next_state = S_A;
            end
            default: next_state = S_A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S_A: begin
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
            S_B: begin
                g[1] = 1;
                g[2] = 0;
                g[3] = 0;
            end
            S_C: begin
                g[1] = 0;
                g[2] = 1;
                g[3] = 0;
            end
            default: begin
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
        endcase
    end
endmodule
