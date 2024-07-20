module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] count;

    // State encoding
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               D = 3'b011,
               E = 3'b100,
               F = 3'b101,
               G = 3'b110;
    
    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;  // Default to remain in the same state
        case (state)
            A: begin
                f = 1'b0;
                g = 1'b0;
                next_state = resetn ? B : A;
            end

            B: begin
                f = 1'b0;
                g = 1'b0;
                if (resetn) begin
                    next_state = C;
                end
            end

            C: begin
                f = 1'b1;
                g = 1'b0;
                next_state = D;
            end

            D: begin
                f = 1'b0;
                g = 1'b0;
                if (x == 1'b1) begin
                    next_state = E;
                end
            end

            E: begin
                f = 1'b0;
                g = 1'b0;
                if (x == 1'b0) begin
                    next_state = F;
                end
                else if (x == 1'b1) begin
                    next_state = E;
                end else begin
                    next_state = D;
                end
            end

            F: begin
                f = 1'b0;
                g = 1'b0;
                if (x == 1'b1) begin
                    next_state = G;
                end
                else if (x == 1'b0) begin
                    next_state = E;
                end else begin
                    next_state = D;
                end
            end

            G: begin
                f = 1'b0;
                g = 1'b1;
                if (y == 1'b1) begin
                    next_state = G;
                end
                else if (count == 2'b10) begin
                    next_state = D;
                end
            end

            default: begin
                next_state = A;
            end
        endcase
    end

    // Output and counter logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 1'b0;
            g <= 1'b0;
            count <= 2'b00;
        end else begin
            case (state)
                A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                    count <= 2'b00;
                end

                B, C, D, E, F: begin
                    f <= (state == C);
                    g <= 1'b0;
                end

                G: begin
                    f <= 1'b0;
                    if (y == 1'b1) begin
                        g <= 1'b1;
                    end else if (count == 2'b10) begin
                        g <= 1'b0;
                    end else begin
                        g <= 1'b1;
                        count <= count + 1;
                    end
                end

                default: begin
                    f <= 1'b0;
                    g <= 1'b0;
                    count <= 2'b00;
                end
            endcase
        end
    end

endmodule
