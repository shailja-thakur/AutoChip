module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Declare the states
    localparam STATE_A = 2'b00;
    localparam STATE_B = 2'b01;
    localparam STATE_C = 2'b10;
    localparam STATE_D = 2'b11;

    // Declare the state register
    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1;
                end
            end
            STATE_B: begin
                if (x == 1) begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                if (x == 0) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (x == 1) begin
                    next_state = STATE_E;
                    g = 1;
                end
            end
            STATE_E: begin
                if (y == 1) begin
                    g = 1;
                end else begin
                    g = 0;
                end
            end
        endcase
    end

endmodule
