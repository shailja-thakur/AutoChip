module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define the states of the FSM
    localparam STATE_A = 3'b000;
    localparam STATE_B = 3'b001;
    localparam STATE_C = 3'b010;
    localparam STATE_D = 3'b011;
    localparam STATE_E = 3'b100;

    reg [2:0] state, next_state;
    reg [1:0] x_count;

    always @(posedge clk, negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            x_count <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                STATE_A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                STATE_B: begin
                    f <= 1'b1;
                    g <= 1'b0;
                end
                STATE_C: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                STATE_D: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
                STATE_E: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (x == 1'b1) begin
                    next_state = STATE_C;
                    x_count <= 2'b01;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (x == 1'b0) begin
                    next_state = STATE_D;
                    x_count <= 2'b10;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_D: begin
                if (x == 1'b1) begin
                    next_state = STATE_E;
                    x_count <= 2'b11;
                end else begin
                    next_state = STATE_D;
                end
            end
            STATE_E: begin
                if (y == 1'b1) begin
                    next_state = STATE_E;
                end else if (x_count == 2'b11) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_A;
                    x_count <= 2'b00;
                end
            end
        endcase
    end

endmodule
