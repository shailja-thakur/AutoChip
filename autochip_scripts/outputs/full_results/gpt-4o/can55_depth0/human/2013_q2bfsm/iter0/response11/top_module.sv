module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic[2:0] {
        A = 3'b000,  // Beginning state
        B = 3'b001,  // After reset, set f to 1
        C = 3'b010,  // Waiting for x sequence 1, 0, 1
        D = 3'b011,  // After detecting 1, 0, 1 sequence
        E = 3'b100,  // Waiting for y to be 1
        F = 3'b101,  // y was 1 within two clock cycles
        G = 3'b110  // y was not 1 within two clock cycles
    } state_t;
    
    state_t state, next_state;
    reg [1:0] x_seq;  // To store x sequence pattern 1, 0, 1
    reg [1:0] y_count;  // To count y check clock cycles

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        // Default assignments
        next_state = state;
        case (state)
            A: begin
                if (!resetn) next_state = B;
            end
            B: begin
                next_state = C;
            end
            C: begin
                if (x_seq == 2'b01) next_state = D;
            end
            D: begin
                next_state = E;
            end
            E: begin
                if (y == 1) next_state = F;
                else if (y_count == 2'b10) next_state = G;
                else next_state = E;
            end
            F: begin
                next_state = F;
            end
            G: begin
                next_state = G;
            end
        endcase
    end

    // Output logic and state-dependent behavioral logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            x_seq <= 0;
            y_count <= 0;
        end else begin
            case (state)
                A: begin
                    f <= 0;
                    g <= 0;
                end
                B: begin
                    f <= 1;
                end
                C: begin
                    f <= 0;
                    x_seq <= {x_seq[0], x};
                    if (x_seq == 2'b01)
                        x_seq <= 0;
                end
                D: begin
                    g <= 1;
                end
                E: begin
                    if (y == 1) begin
                        g <= 1;
                        y_count <= 0;
                    end else if (y_count == 2'b10) begin
                        g <= 0;
                    end else begin
                        y_count <= y_count + 1;
                    end
                end
                F: begin
                    g <= 1;
                end
                G: begin
                    g <= 0;
                end
            endcase
        end
    end

endmodule
