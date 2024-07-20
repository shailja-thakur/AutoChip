module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] y_timer;

    // State encoding
    localparam A = 3'd0;
    localparam B = 3'd1;
    localparam C = 3'd2;
    localparam D = 3'd3;
    localparam E = 3'd4;

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (~resetn) ? A : B;
            B: next_state = C;
            C: next_state = (x && state != C) ? D : C;
            D: next_state = (x && state == D) ? D : E;
            E: next_state = (y || y_timer == 2'd2) ? A : E;
            default: next_state = A;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (~resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (~resetn) begin
            f <= 1'b0;
            g <= 1'b0;
            y_timer <= 2'd0;
        end else begin
            case (state)
                A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                    y_timer <= 2'd0;
                end
                B: f <= 1'b1;
                C: f <= 1'b0;
                D: begin
                    g <= 1'b1;
                    y_timer <= 2'd0;
                end
                E: begin
                    if (y)
                        g <= 1'b1;
                    else if (y_timer == 2'd2)
                        g <= 1'b0;
                    else
                        y_timer <= y_timer + 1;
                end
            endcase
        end
    end
endmodule
