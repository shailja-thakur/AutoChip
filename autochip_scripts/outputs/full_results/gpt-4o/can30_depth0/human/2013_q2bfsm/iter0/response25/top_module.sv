module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    reg [2:0] state, next_state;
    reg [1:0] x_sequence;
    reg [1:0] y_counter;

    localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110;

    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            A: begin
                f = 0;
                g = 0;
                if (~resetn)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                if (x && x_sequence == 2'b01) begin
                    x_sequence <= {x_sequence[0], x};
                    next_state = D;
                end else begin
                    x_sequence <= {x_sequence[0], x};
                    next_state = C;
                end
            end
            D: begin
                if (x_sequence == 2'b10) begin
                    g = 1;
                    next_state = E;
                end else begin
                    x_sequence <= {x_sequence[0], x};
                    next_state = C;
                end
            end
            E: begin
                g = 1;
                if (y) begin
                    next_state = F;
                end else if (y_counter == 2'b10) begin
                    g = 0;
                    next_state = G;
                end else begin
                    y_counter <= y_counter + 1;
                    next_state = E;
                end
            end
            F: begin
                g = 1;
                next_state = F;
            end
            G: begin
                g = 0;
                next_state = G;
            end
        endcase
    end

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            x_sequence <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            case (state)
                B: x_sequence <= 2'b00;
                E: y_counter <= 2'b00;
            endcase
        end
    end
endmodule
