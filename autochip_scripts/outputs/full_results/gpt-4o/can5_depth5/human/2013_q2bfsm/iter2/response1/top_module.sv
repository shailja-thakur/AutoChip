module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // state parameters
    localparam A = 3'b000, 
               B = 3'b001, 
               C = 3'b010, 
               D = 3'b011,
               E = 3'b100,
               F = 3'b101;

    reg [2:0] state, next_state;
    reg [1:0] x_count, y_timer;

    // sequential state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // next state logic and outputs
    always @(*) begin
        // default values
        next_state = state;
        f = 0;
        g = 0;
        case (state)
            A: begin
                if (!resetn)
                    next_state = B;
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                if (x == 1'b1 && x_count == 2'b10)
                    next_state = D;
            end
            D: begin
                g = 1;
                if (y == 1'b1)
                    next_state = F;
                else if (y_timer == 2'b10)
                    next_state = E;
            end
            E: begin
                g = 0;
            end
            F: begin
                g = 1;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // x_count logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            x_count <= 2'b00;
        else if (state == C) begin
            if (x == 1'b1)
                x_count <= {x_count[0], 1'b1};
            else
                x_count <= {x_count[0], 1'b0};
        end else 
            x_count <= 2'b00;
    end

    // y_timer logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            y_timer <= 2'b00;
        else if (state == D && y == 0)
            y_timer <= y_timer + 1;
        else 
            y_timer <= 2'b00;
    end

endmodule
