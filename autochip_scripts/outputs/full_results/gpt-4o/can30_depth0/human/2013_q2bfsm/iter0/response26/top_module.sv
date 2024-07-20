module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101,
        G = 3'b110
    } state_t;

    state_t state, next_state;

    // Sequential logic: State transition
    always_ff @(posedge clk) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic: Next state logic and outputs
    always_comb begin
        // Default values
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            A: begin
                next_state = B;
            end
            B: begin
                f = 1; // Set f to 1 for one clock cycle
                next_state = C;
            end
            C: begin
                if (x == 1) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            D: begin
                if (x == 0) begin
                    next_state = E;
                end else begin
                    next_state = C;
                end
            end
            E: begin
                if (x == 1) begin
                    next_state = F;
                end else begin
                    next_state = C;
                end
            end
            F: begin
                g = 1;
                next_state = G;
            end
            G: begin
                if (y == 1) begin
                    g = 1; // Permanently maintain g = 1
                end else begin
                    case (state)
                        G: begin
                            if (y == 1) begin
                                g = 1; // Permanently maintain g = 1
                            end else begin
                                if ($time - $timechange >= 2) begin // Maintain for 2 clock cycles
                                    g = 0;
                                end else begin
                                    g = 1;
                                end
                            end
                        end
                    endcase
                end
            end
        endcase
    end
endmodule
