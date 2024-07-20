module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] x_count, y_count;

    // State encoding
    localparam [2:0] A = 3'b000,
                     B = 3'b001,
                     C = 3'b010,
                     D = 3'b011,
                     E = 3'b100;
    
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
        case (state)
            A: begin
                f = 1'b0;
                g = 1'b0;
                next_state = resetn ? A : B;
            end

            B: begin
                f = 1'b1;
                g = 1'b0;
                next_state = C;
            end

            C: begin
                f = 1'b0;
                g = 1'b0;
                if (x == 1 && x_count == 2'b00)
                    next_state = C;
                else if (x == 0 && x_count == 2'b01)
                    next_state = C;
                else if (x == 1 && x_count == 2'b10)
                    next_state = D;
                else
                    next_state = C;
            end

            D: begin
                f = 1'b0;
                g = 1'b1;
                if (y == 1'b1) begin
                    next_state = E;
                end
                else if (y_count == 2'b01) begin
                    g = 1'b0;
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end

            E: begin
                f = 1'b0;
                g = g;
                next_state = E;
            end

            default: begin
                f = 1'b0;
                g = 1'b0;
                next_state = A;
            end
        endcase
    end

    // Monitoring x input
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x_count <= 2'b00;
        end
        else if (state == C) begin
            if (x == 1'b1 && x_count == 2'b00) begin
                x_count <= 2'b01;
            end
            else if (x == 1'b0 && x_count == 2'b01) begin
                x_count <= 2'b10;
            end
            else if (x == 1'b1 && x_count == 2'b10) begin
                x_count <= 2'b11;
            end
        end else begin
            x_count <= 2'b00;
        end
    end

    // Monitoring y input
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_count <= 2'b00;
        end
        else if (state == D) begin
            if (y == 1'b0) begin
                y_count <= y_count + 1;
            end else begin
                y_count <= 2'b00;
            end
        end else begin
            y_count <= 2'b00;
        end
    end
endmodule
