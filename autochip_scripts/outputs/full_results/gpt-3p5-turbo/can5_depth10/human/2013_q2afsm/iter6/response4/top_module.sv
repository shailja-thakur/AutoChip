module top_module (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,
    output wire [2:0] g
);

    // Define state codes
    localparam [1:0] A = 2'b00;
    localparam [1:0] B = 2'b01;
    localparam [1:0] C = 2'b10;
    localparam [1:0] D = 2'b11;

    reg [1:0] state;
    reg [1:0] next_state;
    reg [2:0] g_reg;

    // State flip-flop
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // State table
    always @(state or r) begin
        next_state = state; // Default is to stay in the same state

        case (state)
            A: begin
                g_reg <= 3'b000;
                if (r[0] == 0 && r[1] == 0 && r[2] == 0) begin
                    next_state = A;
                end else if (r[0] == 1) begin
                    next_state = B;
                end else if (r[1] == 1) begin
                    next_state = C;
                end else if (r[2] == 1) begin
                    next_state = D;
                end
            end
            B: begin
                if (r[0] == 1 && g_reg[0] == 1) begin
                    next_state = B;
                end else if (r[0] == 0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            C: begin
                if (r[1] == 1 && g_reg[1] == 1) begin
                    next_state = C;
                end else if (r[1] == 0) begin
                    next_state = A;
                end else begin
                    next_state = C;
                end
            end
            D: begin
                if (r[0] == 0 && r[1] == 0 && r[2] == 0) begin
                    next_state = A;
                end else begin
                    next_state = D;
                end
            end
        endcase
    end

    // Continuous assignment for outputs
    always @(state, r) begin
        case (state)
            A: begin
                g_reg[0] = (r[0] == 1) ? 1 : 0;
                g_reg[1] = 0;
                g_reg[2] = (r[1] == 1) ? 1 : 0;
            end
            B: begin
                g_reg[0] = (r[0] == 1) ? 1 : g_reg[0];
                g_reg[1] = (r[1] == 1) ? 1 : 0;
                g_reg[2] = (r[2] == 1) ? 1 : 0;
            end
            C: begin
                g_reg[0] = (r[0] == 1) ? 1 : g_reg[0];
                g_reg[1] = (r[1] == 1) ? 1 : g_reg[1];
                g_reg[2] = (r[2] == 1) ? 1 : 0;
            end
            D: begin
                g_reg[0] = (r[0] == 1) ? 1 : g_reg[0];
                g_reg[1] = (r[1] == 1) ? 1 : g_reg[1];
                g_reg[2] = (r[2] == 1) ? 1 : g_reg[2];
            end
        endcase
    end

    // Output assignment
    assign g = g_reg;

endmodule
