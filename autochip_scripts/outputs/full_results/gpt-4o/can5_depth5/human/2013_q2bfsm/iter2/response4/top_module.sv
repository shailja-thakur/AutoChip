module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] x_count, y_timer;

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
            x_count <= 2'b00;
            y_timer <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end
        else begin
            state <= next_state;
            if(state == B)
                f <= 1'b1;
            else
                f <= 1'b0;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                next_state = (!resetn) ? A : B;
            end

            B: begin
                next_state = C;
            end

            C: begin
                if (x_count == 2'b11 && x == 1'b1) begin
                    next_state = D;
                end
                else begin
                    next_state = C;
                end
            end

            D: begin
                if (y == 1'b1) begin
                    g = 1'b1;
                    next_state = E;
                end
                else if (y_timer == 2'b10) begin
                    g = 1'b0;
                    next_state = E;
                end
                else begin
                    g = 1'b1;
                    next_state = D;
                end
            end

            E: begin
                next_state = E;
            end

            default: begin
                next_state = A;
            end
        endcase
    end

    // Monitoring x input for sequence 1, 0, 1
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
            else if (x_count != 2'b11) begin
                x_count <= 2'b00;
            end
        end
        else begin
            x_count <= 2'b00;
        end
    end

    // Monitoring y input with a timer for 2 cycles
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_timer <= 2'b00;
        end
        else if (state == D && y != 1'b1) begin
            y_timer <= y_timer + 1;
        end
        else begin
            y_timer <= 2'b00;
        end
    end
endmodule
